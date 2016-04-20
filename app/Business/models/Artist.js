module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Artist', {
    ArtistId: {
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
    tableName: 'Artist',
    freezeTableName: true
  });
};
