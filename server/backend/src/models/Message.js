const { Sequelize, Model, DataTypes } = require("sequelize");
const sequelize = new Sequelize('chatapp', 'postgres', 'postgres', {
    host: 'localhost',
    dialect: 'postgres'
  });
module.exports = sequelize.define("message", {
  text: {type:DataTypes.TEXT,
    allowNull: false
  },
  sender: {
    type:DataTypes.STRING,
    allowNull: false
  },
  reciver: {
    type: DataTypes.STRING,
    allowNull: false
  },
},
{
    timestamps: true
});

