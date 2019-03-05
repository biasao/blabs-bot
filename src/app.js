const restify = require('restify');
const builder = require('botbuilder');
let dialogLoader = require('./grammar/dialog-loader');

// Setup Restify Server
var server = restify.createServer();
server.listen(process.env.port || process.env.PORT || 3978, function () {
    console.log('%s listening to %s', server.name, server.url);
});

// Create chat connector for communicating with the Bot Framework Service
var connector = new builder.ChatConnector({
    appId: process.env.MicrosoftAppId,
    appPassword: process.env.MicrosoftAppPassword
});

// Listen for messages from users 
server.post('/api/messages', connector.listen());

var inMemoryStorage = new builder.MemoryBotStorage();

// This is a dinner reservation bot that uses a waterfall technique to prompt users for input.
var bot = new builder.UniversalBot(connector, function(session) {
    session.beginDialog('mainDialog');
}).set('storage', inMemoryStorage); // Register in-memory storage


let dinnerReservation = dialogLoader.load('./src/dialogs/dinner-reservation.dialog')
bot.dialog(
    'mainDialog',
    dinnerReservation
);