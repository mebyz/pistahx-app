    module.exports = function(sequelize) {
      var m = sequelize.import('./Genre.js');
      return m;
    };
