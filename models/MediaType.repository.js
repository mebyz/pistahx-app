    module.exports = function(sequelize) {
      var m = sequelize.import('./MediaType.model.js');
    m.findWithAssoc = function(limit, order, cb) {
    var pp=[];
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
