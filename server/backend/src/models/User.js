const { Sequelize, Model, DataTypes } = require("sequelize");
const sequelize = new Sequelize('chatapp', 'postgres', 'postgres', {
    host: 'localhost',
    dialect: 'postgres'
  });
module.exports = sequelize.define("user", {
  username: {
    type:DataTypes.STRING,
    allowNull: false,
    unique: true
  },
  password: {
    type:DataTypes.STRING,
    allowNull: false
  }
}
);

