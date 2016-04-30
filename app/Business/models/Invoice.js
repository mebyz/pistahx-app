module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Invoice', {
    InvoiceId: {
      primaryKey: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined
    },
    CustomerId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined,
      references: {
        model: 'Customer',
        key: 'CustomerId'
      }
    },
    InvoiceDate: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: undefined
    },
    BillingAddress: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    BillingCity: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    BillingState: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    BillingCountry: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    BillingPostalCode: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    Total: {
      type: 'NUMERIC(10,2)',
      allowNull: false,
      defaultValue: undefined
    }
  }, {
    tableName: 'Invoice', timestamps: false,
    freezeTableName: true
  });
};
