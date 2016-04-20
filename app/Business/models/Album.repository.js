    module.exports = function(sequelize) {
      var m = sequelize.import('./Album.model.js');
      var p = sequelize.import('./Artist.model.js');
      m.findWith_Artist = function(limit) {
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
      var p = sequelize.import('./Artist.model.js');
      pp.push({ model: p, as: 'Artist' });
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
