const { Router } = require('express');
const { response } = require('../app');
const Message = require('../models/Message');
const faker = require('faker');
const router = Router();
const { Op, Sequelize, QueryTypes  } = require("sequelize");
const sequelize = new Sequelize('chatapp', 'postgres', 'postgres', {
    host: 'localhost',
    dialect: 'postgres'
  });


router.get('/api/messages', async (request, response) => {
    await Message.findAll().then((messages) => {
        if (messages) {
            response.json(messages);
        }
        else {
            response.status(404).send();
        }
    });
});

router.post('/api/messages/send', async (request, response) => {

    const { text, sender, reciver } = request.body;

    await Message.create({
        text: text,
        sender: sender,
        reciver: reciver,
    });
});

router.get('/api/messages/:sender/:reciver/ordered', async (request, response) => {

    console.log(request.params);
    var sender = request.params["sender"];
    var reciver = request.params["reciver"];
    try{
const messages = await sequelize.query('SELECT * FROM messages WHERE sender = $sender AND reciver = $reciver OR sender = $reciver AND reciver = $sender ORDER BY "createdAt" ASC', 
        {
            bind: {
                sender: sender,
                reciver: reciver,
             },
            type: QueryTypes.SELECT,
            model: Message,
            mapToModel: true // pass true here if you have any mapped fields
          });
          if(messages){
            response.json(messages);
          }
          else{
            response.status(404).send();
          }
    }
    catch (err)
    {
        response.status(404).send();
        console.log(err);
    }
});
module.exports = router
