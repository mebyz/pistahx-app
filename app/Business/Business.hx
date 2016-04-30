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

import haxe.Json.*;

// THX
import thx.core.*;
import thx.Iterables.*;

import Business_AST;
import TD;

using js.node.http.ServerResponse;
using js.node.http.ClientRequest;
using js.node.http.IncomingMessage;


// Business : BUSINESS LOGIC :
// ---------
class Business {

  public static function main() {  }


  public static function sinkOutput(res: js.node.http.ServerResponse, d : Dynamic) { 
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(stringify(d));
    return;
  }

  public static function get_employees(db : Sequelize,req : ClientRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) {
    
    var employee : Dynamic = untyped __js__('db.import("models/Employee.js");');

    return employee   
    .findAll({    
         limit : 10
    })    
    .then(function(emps) {    
      var vb = map([emps], function(d) {
          return EmployeeMapper.mapEmployees(d, EmployeeDecorator.decorate);
      }); 
      return Lambda.array(vb[0]);
    });
  }

  public static function get_employee(db : Sequelize,req : ClientRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) {
    
    var employee : Dynamic = untyped __js__('db.import("models/Employee.js");');

    return employee   
    .find({
          where: [ { 'EmployeeId' : untyped req.params.EmployeeId } ]
    })    
    .then(function(emp) {    
      var vb = map([emp], function(e) {
          return EmployeeMapper.mapEmployees([e], EmployeeDecorator.decorate);
      }); 
      sinkOutput(res, Lambda.array(vb[0]));
      return;   
    });
  }

  public static function put_employee(db : Sequelize,req : ClientRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) {
    
    var employee : Dynamic = untyped __js__('db.import("models/Employee.js");');
    
    var body = Reflect.field(req,'body');

    var doutfields = Reflect.fields(body);

    return employee.find({ where: [ { 'EmployeeId' : untyped body.id } ],include: [ ],raw:false })
    .then(function(em) {
      var vb = EmployeeMapper.mapDBEmployee(em);

      trace(vb);
      
      var dout = untyped {};
      for (f in doutfields){
        if (f != 'id' 
          &&
          Reflect.field(vb,f) 
           != Reflect.field(body,f) )
        {
          Reflect.setField(dout,f,Reflect.field(body,f));
        }
      
      } 

      untyped em.update(dout).then(function() {
        sinkOutput(res, 'ok');
      });
    });
    return;
  }
/*
  //    /users (GET)
  public static function get_users(db : Sequelize, req : ClientRequest, res : ServerResponse, dbcacher : Dynamic, outputcacher : Dynamic, extra : Dynamic) {
   
          var REQ1 = untyped require('path').dirname(require.main.filename) + '/sql/user_info1.sql';
          var REQ2 = untyped require('path').dirname(require.main.filename) + '/sql/user_info2.sql'; 
          
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
        
          // sample model to db SYNC !
          // ie : will create table if not exists
          var model = new Model(untyped db);
          var Cars = model.getCars();
          Cars.sync();

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

  */
}
