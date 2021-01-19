const { Router } = require('express');
const { response } = require('../app');
const User = require('../models/User');
const faker = require('faker');
const router = Router();
const { Op, Sequelize, QueryTypes  } = require("sequelize");
const sequelize = new Sequelize('chatapp', 'postgres', 'postgres', {
    host: 'localhost',
    dialect: 'postgres'
  });

router.get('/api/users', async (request, response) => {
    await User.findAll().then((users) => {
        if (users) {
            response.json(users);
        }
        else {
            response.status(404).send();
        }
    });
});


router.get('/api/users/except/:username', async (request, response) => {
    console.log("get all users except a specific router called");
    console.log(request.params);
    var username = request.params["username"];
    console.log(username);
    // response.json(username);
    try{
        const users = await sequelize.query('SELECT * FROM users WHERE username NOT LIKE $authname', 
        {
            bind: {authname: username },
            type: QueryTypes.SELECT,
            model: User,
            mapToModel: true // pass true here if you have any mapped fields
          });
          if(users){
            response.json(users);
          }
          else{
            response.status(404).send();

          }
    }
    catch (err)
    {
        console.log(err);
    }
});

// router.get('/api/users/create', async (request, response) => {
//     for (let i = 0; i < 5; i++) {
//         await User.create({
//             username: faker.name.firstName(),
//             password: faker.name.firstName(),
//         });
//     }
//     response.json({ message: '5 User created' });
// });

router.post('/api/users/signup', async (request, response) => {
    console.log("singnup router called");

    const { username, password } = request.body;
    console.log(username);
    const [user, created] = await User.findOrCreate({
        where: { username: username },
        defaults: {
            password: password
        }
    });
    if (created) {
        console.log("new user created");
    }
    else {
        console.log("user not created");
    }
    response.json({ token: "signed Up", user: username });
});

module.exports = router