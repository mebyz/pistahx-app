    module.exports = function(sequelize) {
      var m = sequelize.import('./InvoiceLine.js');
      var Invoice = sequelize.import('./Invoice.js');
      m.hasOne(Invoice, { as: 'Invoice', foreignKey: 'InvoiceId'});
      var Track = sequelize.import('./Track.js');
      m.hasOne(Track, { as: 'Track', foreignKey: 'TrackId'});
      return m;
    };
