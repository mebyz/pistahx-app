module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Genre', {
    GenreId: {
      primaryKey: true,
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined
    },
    Name: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    }
  }, {
    tableName: 'Genre', timestamps: false,
    freezeTableName: true
  });
};
