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

import TD;

using js.node.http.ServerResponse;
using js.node.http.ClientRequest;
using js.node.http.IncomingMessage;

using Main.PistahxRequest;


class EmployeeDecorator { 
    public static function decorate(b : Employee): Employee { 
        b.lastName+=' :)'; // sample use
        return b; 
    }
}

class IdentityDecorator { 
    public static function decorate(t : Dynamic): Dynamic { 
        return t; 
    }
}

//// # 2
//typedef DBAlbums = {
//  findAll : FindAllOptions -> Promise<Array<DB__Album>>,
//  find : FindOptions -> Promise<DB__Album>
//}
//
//typedef DBArtists = {
//  findAll : FindAllOptions -> Promise<Array<DB__Album>>,
//  find : FindOptions -> Promise<DB__Album>
//}

typedef DBEmployees = {
  findAll : FindAllOptions -> Promise<Array<DB__Employee>>,
  find : FindOptions -> Promise<DB__Employee>,
  update : Dynamic -> Promise<DB__Employee>
}

@:publicFields
class DbRepos {

  var dbEmployees : DBEmployees;

  //// # 3
  //var dbAlbums : DBAlbums;
  //var dbArtist : DBArtists;

  function new(db : Sequelize) {
    dbEmployees = db.import_("models/Employee.js");
    //// # 4
    //dbAlbums = db.import_("models/Album.js");
    //dbArtist = db.import_("models/Artist.js");
    //untyped dbAlbums.belongsTo(dbArtist, {foreignKey: 'ArtistId'});
  }

}

typedef FindAllOptions = {
  ?limit : Int,
  ?include : Array<Dynamic>,
  ?raw : Bool,
  ?order : String
}

typedef FindOptions = {
  ?where : Array<Dynamic>,
  ?include : Array<Dynamic>,
  ?raw : Bool 
}


// Business : BUSINESS LOGIC :
// ---------
class Business {

  public static function main() {  }


  public static function sinkOutput(res: js.node.http.ServerResponse, d : Dynamic) {
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(stringify(d));
    return;
  }


//// # 5
//  public static function get_albums(db : Sequelize,req : PistahxRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) : Promise<Array<Album>> {    
//
//    var dbr = new DbRepos(db);
//
//    return
//      dbr.dbAlbums.findAll({
//        limit : 5,
//        raw:true,
//        include : [{model: dbr.dbArtist, as: 'Artist'}]
//      }).then(function (dbAlbumRes) {
//        return dbAlbumRes.map(AlbumMapper.dbAlbumToAlbum); 
//      });
//
//  }
//
//  public static function get_album(db : Sequelize,req : PistahxRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) : Promise<Album> {
//  
//    var dbr = new DbRepos(db);
//
//    return
//      dbr.dbAlbums.find({
//         where: [ { 'AlbumId' : req.params.AlbumId } ],
//         raw:true,
//         include : [{model: dbr.dbArtist, as: 'Artist'}]
//      }).then(function (dbAlbumRes) {
//        return AlbumMapper.dbAlbumToAlbum(dbAlbumRes);
//      });
//  }


  public static function get_employees(db : Sequelize,req : PistahxRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) : Promise<Array<Employee>> {    

    var dbr = new DbRepos(db);

    return
      dbr.dbEmployees.findAll({
        limit : 5
      }).then(function (dbEmployeesRes) {
        return dbEmployeesRes.map(EmployeeMapper.dbEmployeeToEmployee); 
      });

  }

  public static function get_employee(db : Sequelize,req : PistahxRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) : Promise<Employee> {
  
    var dbr = new DbRepos(db);

    return
      dbr.dbEmployees.find({
         where: [ { 'EmployeeId' : req.params.EmployeeId } ]
      }).then(function (dbEmployeeRes) {
        return EmployeeMapper.dbEmployeeToEmployee(dbEmployeeRes);
      });
  }

  public static function put_employee(db : Sequelize,req : PistahxRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) : Promise<Employee> {
    
    var dbr = new DbRepos(db);

    var body = Reflect.field(req,'body');
    var doutfields = Reflect.fields(body);
    
    return dbr.dbEmployees.find({ where: [ { 'EmployeeId' :  body.id } ],include: [ ],raw:false })
    .then(function(em) {
      var vb = EmployeeMapper.employeeToDbEmployee(body);
      return untyped em.update(vb).then(function() {
        return vb;
      });
    });
  }

}
