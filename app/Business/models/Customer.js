module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Customer', {
    CustomerId: {
      primaryKey: true,
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined
    },
    FirstName: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: undefined
    },
    LastName: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: undefined
    },
    Company: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    Address: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    City: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    State: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    Country: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    PostalCode: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    Phone: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    Fax: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    Email: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: undefined
    },
    SupportRepId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: undefined,
      references: {
        model: 'Employee',
        key: 'EmployeeId'
      }
    }
  }, {
    tableName: 'Customer', timestamps: false,
    freezeTableName: true
  });
};
