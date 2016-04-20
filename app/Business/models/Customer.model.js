    module.exports = function(sequelize) {
      var m = sequelize.import('./Customer.js');
      var Employee = sequelize.import('./Employee.js');
      m.hasOne(Employee, { as: 'Employee', foreignKey: 'EmployeeId'});
      return m;
    };
