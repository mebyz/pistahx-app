import js.node.Crypto;
import js.node.Buffer;
import js.npm.sequelize.Sequelize;
import js.npm.sequelize.DataTypes;
import js.npm.sequelize.Instance;
import js.npm.sequelize.Model;
import js.node.crypto.Hash;
import js.node.Fs;

// PROMHX PROMISES
import promhx.Promise.Promise;
import promhx.Deferred;

import Models;

class Model extends Models { }

// Business : BUSINESS LOGIC :
// ---------
class Business {
  public static function main() {  }

  //    /users (GET)
  public static function get_users(db : Sequelize, req : Dynamic, res : Dynamic, dbcacher : Dynamic, outputcacher : Dynamic, extra : Dynamic) {
   
          var REQ1 = untyped require('path').dirname(require.main.filename) + '/../app/Business/sql/user_info1.sql';
          var REQ2 = untyped require('path').dirname(require.main.filename) + '/../app/Business/sql/user_info2.sql'; 
          
          // REQS ARRAY CONTAINS OUR RAW QUERIES
          var reqs : Map<Int, String> = [
            0 => REQ1, 
            1=> REQ2
          ];

          // PARAMS ARRAY WILL BE USED TO GENERATE THE QUERY
          //var params : Map<String, String> = [ ... ];

          // HERE RESIDES THE MAGIC PART : A PROMISE WATERFALL OF ACTIONS
          // SOME ACTIONS TRIGGER SOME ASYNC / PARALLEL SUBPROMISES
          
          // FIRST PROMISE : LOAD SQL FILES
          Promise.when(
            loadfilePromise(reqs[0]), 
            loadfilePromise(reqs[1])
          )
          // 2ND PROMISE : GATHER RESULTING SQL STRINGS IN AN ARRAY
          .then(function(a,b) return joinQueries(a,b))
          // 3RD PROMISE : REPLACE PARAMETERS IN EACH SQL QUERY
          //.then(function(d)   return replaceParams(d, params))
          // 4TH PROMISE : RUN SQL QUERIES
          .then(function(e) {
            runParallelQueries(e,db,res)
            .then(function(result) {
              trace(result);
            });
          });
        
  }


  public static function loadfilePromise(reqFile : String) : Promise<String>{
      var p = new Deferred<String>();
        js.node.Fs.readFile(reqFile, 'utf8', function(err,data){
          p.resolve(data);
        });
      return p.promise();
  }

  public static function joinQueries(a : String, b : String) : Map<Int, String>{
      var reqs : Map<Int, String> = [0 => a, 1=> b];     
      return reqs;
  }

  public static function replaceParams(reqsArray : Map<Int, String>, params : Map<String, String>) : Map<Int, String>{
      for(r in reqsArray.keys()) {
        for (key in params.keys()){    
              var re = new EReg(key,"igm");
              // REPLACE HERE
               reqsArray[r] = re.replace( reqsArray[r],
                params[key]);
          }
        }
    return reqsArray;
  }

  public static function runParallelQueries(reqsArray : Map<Int, String>, db : Sequelize, res : Dynamic) : Promise<String> {
      var p = new Deferred<String>();
      
      var sql1 = reqsArray[0];
      var sql2 = reqsArray[1];

      // PARALLEL CALL SOME QUERIES USING PROMISES
      var SPromise = untyped Sequelize.Promise;
      SPromise.map([
          sql1,
          sql2
      ], function runQuery(query) {
          return db.query(query, { type : 'SELECT' });
      }).then(function(result) {
          res.statusCode = 200;
          res.send(haxe.Json.stringify([result[0][0],[result[1][0]]]));
          p.resolve(haxe.Json.stringify(result));
      });
      return p.promise();
  }
}
