    module.exports = function(sequelize) {
      var m = sequelize.import('./MediaType.js');
      return m;
    };
