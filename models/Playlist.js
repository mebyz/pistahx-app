module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Playlist', {
    PlaylistId: {
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
    tableName: 'Playlist',
    freezeTableName: true
  });
};
