    module.exports = function(sequelize) {
      var m = sequelize.import('./Customer.model.js');
      var p = sequelize.import('./Employee.model.js');
      m.findWith_Employee = function(limit) {
        m.findAll({
          include: [{ model: p, as: 'p' }],
          limit: limit,
          raw: true
        })
        .then(function(rows) {
          console.log(rows);
        });
      }
    m.findWithAssoc = function(limit, order, cb) {
    var pp=[];
      var p = sequelize.import('./Employee.model.js');
      pp.push({ model: p, as: 'Employee' });
        m.findAll({
          include: pp,
          order: order,
          limit: limit,
          raw: true
        })
        .then(function(rows) {
          cb(rows);
        });
    }
    m.findBy = function(attr, value, cb) {
        m.findAll({
          where: {
          attr: value
          },
          limit: limit,
          raw: true
        })
        .then(function(rows) {
          cb(rows);
        });
    }
    return m;
    };
