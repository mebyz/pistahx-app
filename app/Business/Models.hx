import js.npm.sequelize.Sequelize;
import js.npm.sequelize.DataTypes;
import js.npm.sequelize.Instance;
import js.npm.sequelize.Model;

class Models {

  public static var Users : Dynamic;

  public function getUsers(){
    return Users;
  }
  public function new(db) {
      
      // MODELS & ASSOCIATIONS

      Users = db.define('users', untyped {
        UserId: 
        {
          type: DataTypes.STRING(),
          primaryKey: true
        },
        UserName: { type: DataTypes.STRING() }
      },
      {
        timestamps: false,
        freezeTableNames: true,
        tableName: 'Users'
      });
  }
  public function main() {

  }
}