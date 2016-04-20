module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Track', {
    TrackId: {
      primaryKey: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined
    },
    Name: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: undefined
    },
    AlbumId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: undefined,
      references: {
        model: 'Album',
        key: 'AlbumId'
      }
    },
    MediaTypeId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined,
      references: {
        model: 'MediaType',
        key: 'MediaTypeId'
      }
    },
    GenreId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: undefined,
      references: {
        model: 'Genre',
        key: 'GenreId'
      }
    },
    Composer: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: undefined
    },
    Milliseconds: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: undefined
    },
    Bytes: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: undefined
    },
    UnitPrice: {
      type: 'NUMERIC(10,2)',
      allowNull: false,
      defaultValue: undefined
    }
  }, {
    tableName: 'Track',
    freezeTableName: true
  });
};
