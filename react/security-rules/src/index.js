import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';
import firebase from "firebase/app";
import "firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyBY0y7adhWArVXBiFeyCvw0i5VV5RHzOwo",
  authDomain: "time-entries-12b5d.firebaseapp.com",
  projectId: "time-entries-12b5d",
  storageBucket: "time-entries-12b5d.appspot.com",
  messagingSenderId: "705048205294",
  appId: "1:705048205294:web:ab1468dbfa3a99450560ff",
  databaseURL: "https://time-entries-12b5d-default-rtdb.firebaseio.com/",
  measurementId: "G-CP628CHRQB"
};

firebase.initializeApp(firebaseConfig);

const auth = firebase.auth();
auth.useEmulator("http://localhost:9099");

var db = firebase.firestore();
if (window.location.hostname === "localhost") {
  db.useEmulator("localhost", 8080);
}

var storage = firebase.storage();
storage.useEmulator("localhost", 9199);

var functions = firebase.functions();
functions.useEmulator("localhost", 5001);

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
