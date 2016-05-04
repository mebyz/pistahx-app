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

typedef EmployeesFindAllOptions = {
  limit : Int
}

typedef EmployeesFindOptions = {
  where : Array<Dynamic>
}

typedef DBEmployees = {
  findAll : Business.EmployeesFindAllOptions -> Promise<Array<DB__Employee>>,
  find : Business.EmployeesFindOptions -> Promise<DB__Employee>
}

@:publicFields
class DbRepos {

  static var dbEmployees : DBEmployees;

  function new(db : Sequelize) {
    dbEmployees = db.import_("models/Employee.js");
  }
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

  public static function get_employees(db : Sequelize,req : ClientRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) : Promise<Array<Employee>> {    

    return
      DbRepos.dbEmployees.findAll({
        limit : 5
      }).then(function (dbEmployeesRes) {
        return dbEmployeesRes.map(EmployeeMapper.dBEmployeeToEmployee); // Le repo devrait exposer les objets business.
      });

  }

  public static function get_employee(db : Sequelize,req : ClientRequest, res : ServerResponse, dbcacher : Dynamic,outputcacher : Dynamic, extra : Dynamic) : Promise<Employee> {
  
    return
      DbRepos.dbEmployees.find({
         where: [ { 'EmployeeId' : untyped req.params.EmployeeId } ]
      }).then(function (dbEmployeeRes) {
        return EmployeeMapper.dBEmployeeToEmployee(dbEmployeeRes);
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
