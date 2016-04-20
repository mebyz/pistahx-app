    module.exports = function(sequelize) {
      var m = sequelize.import('./PlaylistTrack.js');
      var Playlist = sequelize.import('./Playlist.js');
      m.hasOne(Playlist, { as: 'Playlist', foreignKey: 'PlaylistId'});
      var Track = sequelize.import('./Track.js');
      m.hasOne(Track, { as: 'Track', foreignKey: 'TrackId'});
      return m;
    };
