module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Employee', {
    EmployeeId: {
      primaryKey: true,
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined
    },
    LastName: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: undefined
    },
    FirstName: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: undefined
    },
    Title: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    ReportsTo: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: undefined,
      references: {
        model: 'Employee',
        key: 'EmployeeId'
      }
    },
    BirthDate: {
      type: DataTypes.DATE,
      allowNull: true,
      defaultValue: undefined
    },
    HireDate: {
      type: DataTypes.DATE,
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
      allowNull: true,
      defaultValue: undefined
    }
  }, {
    tableName: 'Employee', timestamps: false,
    freezeTableName: true
  });
};
