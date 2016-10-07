import js.npm.sequelize.Sequelize;
import js.npm.sequelize.DataTypes;
import js.npm.sequelize.Instance;
import js.npm.sequelize.Model;

// PROMHX PROMISES
import promhx.Promise.Promise;
import promhx.Deferred;

import js.node.Crypto;
import js.node.Buffer;
import js.node.crypto.Hash;

class Auth {


  private static var _db;

  public function new(db : Dynamic) {
      
    _db = db;
    
  }

  public function main() {

  }

  public function secure(username: String, password: String) : Promise<Int>
  { 

    var p = new Deferred<Int>();
    var result = -1; // default is unauth ;)

    // DO AUTH HERE

    p.resolve(result);
    return p.promise();
  }


}