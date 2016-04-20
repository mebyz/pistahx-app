    module.exports = function(sequelize) {
      var m = sequelize.import('./Employee.js');
      var Employee = sequelize.import('./Employee.js');
      m.hasOne(Employee, { as: 'Employee', foreignKey: 'EmployeeId'});
      return m;
    };
