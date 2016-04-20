module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Genre', {
    GenreId: {
      primaryKey: true,
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
    tableName: 'Genre',
    freezeTableName: true
  });
};
