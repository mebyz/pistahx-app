    module.exports = function(sequelize) {
      var m = sequelize.import('./Album.js');
      var Artist = sequelize.import('./Artist.js');
      m.hasOne(Artist, { as: 'Artist', foreignKey: 'ArtistId'});
      return m;
    };
