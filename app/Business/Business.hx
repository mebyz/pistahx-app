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


////// # 5
//  public static function get_albums(db : Sequelize,req : ClientRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) : Promise<Array<Album>> {    
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
//  public static function get_album(db : Sequelize,req : ClientRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) : Promise<Album> {
//  
//    var dbr = new DbRepos(db);
//
//    return
//      dbr.dbAlbums.find({
//         where: [ { 'AlbumId' : untyped req.params.AlbumId } ],
//         raw:true,
//         include : [{model: dbr.dbArtist, as: 'Artist'}]
//      }).then(function (dbAlbumRes) {
//        return AlbumMapper.dbAlbumToAlbum(dbAlbumRes);
//      });
//  }


  public static function get_employees(db : Sequelize,req : ClientRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) : Promise<Array<Employee>> {    

    var dbr = new DbRepos(db);

    return
      dbr.dbEmployees.findAll({
        limit : 5
      }).then(function (dbEmployeesRes) {
        return dbEmployeesRes.map(EmployeeMapper.dbEmployeeToEmployee); 
      });

  }

  public static function get_employee(db : Sequelize,req : ClientRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) : Promise<Employee> {
  
    var dbr = new DbRepos(db);

    return
      dbr.dbEmployees.find({
         where: [ { 'EmployeeId' : untyped req.params.EmployeeId } ]
      }).then(function (dbEmployeeRes) {
        return EmployeeMapper.dbEmployeeToEmployee(dbEmployeeRes);
      });
  }
/*
  public static function put_employee(db : Sequelize,req : ClientRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) {
    
    var employee : Dynamic = untyped __js__('db.import("models/Employee.js");');
    
    var body = Reflect.field(req,'body');
    var doutfields = Reflect.fields(body);
    return employee.find({ where: [ { 'EmployeeId' : untyped body.id } ],include: [ ],raw:false })
    .then(function(em) {
      var vb = EmployeeMapper.mapDBEmployee(body);
      untyped em.update(vb).then(function() {
      });
    });
    return;
  }
*/
}
