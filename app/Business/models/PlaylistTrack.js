module.exports = function(sequelize, DataTypes) {
  return sequelize.define('PlaylistTrack', {
    PlaylistId: {
      primaryKey: true,
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined,
      references: {
        model: 'Playlist',
        key: 'PlaylistId'
      }
    },
    TrackId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined,
      references: {
        model: 'Track',
        key: 'TrackId'
      }
    }
  }, {
    tableName: 'PlaylistTrack', timestamps: false,
    freezeTableName: true
  });
};
