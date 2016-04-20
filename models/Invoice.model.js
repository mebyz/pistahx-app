    module.exports = function(sequelize) {
      var m = sequelize.import('./Invoice.js');
      var Customer = sequelize.import('./Customer.js');
      m.hasOne(Customer, { as: 'Customer', foreignKey: 'CustomerId'});
      return m;
    };
