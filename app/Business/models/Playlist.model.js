    module.exports = function(sequelize) {
      var m = sequelize.import('./Playlist.js');
      return m;
    };
