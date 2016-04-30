module.exports = function(sequelize, DataTypes) {
  return sequelize.define('MediaType', {
    MediaTypeId: {
      primaryKey: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined
    },
    Name: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    }
  }, {
    tableName: 'MediaType', timestamps: false,
    freezeTableName: true
  });
};
