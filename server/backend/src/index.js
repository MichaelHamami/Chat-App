const app = require('./app');
const User = require('./models/User');
const Message = require('./models/Message');
const faker = require('faker');

const { Sequelize } = require("sequelize");
const sequelize = new Sequelize('chatapp', 'postgres', 'postgres', {
    host: 'localhost',
    dialect: 'postgres'
  });

async function main()
{
    await app.listen(4000);
    console.log('Server on port 4000');
    // for (let i = 0; i < 5; i++) {
    //   await Message.create({
    //       text: faker.name.firstName(),
    //       sender: i.toString(),
    //       reciver: (i+1).toString()
    //   });
    // }
    // To CREATE USER TABLE
    // (async () => {
    //     await User.sync({ force: true });
    //     console.log('User table created');
    // })();
    //     // To CREATE Message TABLE
    //     (async () => {
    //     await Message.sync({ force: true });
    //     console.log('Message table created');
    // })();
}

main();