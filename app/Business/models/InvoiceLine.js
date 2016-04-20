module.exports = function(sequelize, DataTypes) {
  return sequelize.define('InvoiceLine', {
    InvoiceLineId: {
      primaryKey: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined
    },
    InvoiceId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined,
      references: {
        model: 'Invoice',
        key: 'InvoiceId'
      }
    },
    TrackId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined,
      references: {
        model: 'Track',
        key: 'TrackId'
      }
    },
    UnitPrice: {
      type: 'NUMERIC(10,2)',
      allowNull: false,
      defaultValue: undefined
    },
    Quantity: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined
    }
  }, {
    tableName: 'InvoiceLine',
    freezeTableName: true
  });
};
