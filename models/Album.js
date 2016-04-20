module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Album', {
    AlbumId: {
      primaryKey: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined
    },
    Title: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: undefined
    },
    ArtistId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined,
      references: {
        model: 'Artist',
        key: 'ArtistId'
      }
    }
  }, {
    tableName: 'Album',
    freezeTableName: true
  });
};
