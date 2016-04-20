    module.exports = function(sequelize) {
      var m = sequelize.import('./Track.js');
      var Album = sequelize.import('./Album.js');
      m.hasOne(Album, { as: 'Album', foreignKey: 'AlbumId'});
      var MediaType = sequelize.import('./MediaType.js');
      m.hasOne(MediaType, { as: 'MediaType', foreignKey: 'MediaTypeId'});
      var Genre = sequelize.import('./Genre.js');
      m.hasOne(Genre, { as: 'Genre', foreignKey: 'GenreId'});
      return m;
    };
