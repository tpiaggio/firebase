const admin = require('firebase-admin');
const functions = require('firebase-functions');
const fetch = require("node-fetch");

admin.initializeApp();

const ENDPOINT = "https://us-central1-time-entries-12b5d.cloudfunctions.net/getWeather";

exports.createTimer = functions.firestore.document('/times/{timesId}').onCreate(async (snap) => {
  const tokenRef = await admin.firestore().collection("tokens").doc(snap.data().user_id).get();
  const message = {
    data: {
      message: "Timer created with id: " + snap.id
    },
    token: tokenRef.data().webToken
  };
  
  admin.messaging().send(message)
    .then((response) => {
      // Response is a message ID string.
      console.log('Successfully sent message:', response);
    })
    .catch((error) => {
      console.log('Error sending message:', error);
    });


  const { location } = snap.data();
  const body = JSON.stringify({ location });
  const response = await fetch(ENDPOINT, {method: "POST", body});
  const weather = await response.json();
  return snap.ref.update({weather});
});

exports.getWeather = functions.https.onRequest((req, res) => {
  const { location } = JSON.parse(req.body);

  const WEATHER_MAP = {
    "Montevideo": Math.random() * 10 + 10,
    "London": Math.random() * 10 + 15,
    "Miami": Math.random() * 10 + 20,
  };

  const SKY_ARRAY = ["☀️", "⛅️", "🌧"];

  const temperature = WEATHER_MAP[location];
  const sky = SKY_ARRAY[Math.floor(Math.random() * SKY_ARRAY.length)];

  response.json({
    temperature,
    sky,
    metric: "celsius"
  });
});
