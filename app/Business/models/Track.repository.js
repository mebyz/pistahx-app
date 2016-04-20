    module.exports = function(sequelize) {
      var m = sequelize.import('./Track.model.js');
      var p = sequelize.import('./Album.model.js');
      m.findWith_Album = function(limit) {
        m.findAll({
          include: [{ model: p, as: 'p' }],
          limit: limit,
          raw: true
        })
        .then(function(rows) {
          console.log(rows);
        });
      }
      var p = sequelize.import('./MediaType.model.js');
      m.findWith_MediaType = function(limit) {
        m.findAll({
          include: [{ model: p, as: 'p' }],
          limit: limit,
          raw: true
        })
        .then(function(rows) {
          console.log(rows);
        });
      }
      var p = sequelize.import('./Genre.model.js');
      m.findWith_Genre = function(limit) {
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
      var p = sequelize.import('./Album.model.js');
      pp.push({ model: p, as: 'Album' });
      var p = sequelize.import('./MediaType.model.js');
      pp.push({ model: p, as: 'MediaType' });
      var p = sequelize.import('./Genre.model.js');
      pp.push({ model: p, as: 'Genre' });
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
