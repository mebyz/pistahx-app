    module.exports = function(sequelize) {
      var m = sequelize.import('./Artist.js');
      return m;
    };
