module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Playlist', {
    PlaylistId: {
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
    tableName: 'Playlist', timestamps: false,
    freezeTableName: true
  });
};
