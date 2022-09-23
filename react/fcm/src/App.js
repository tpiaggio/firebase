import { useState, useEffect } from 'react';
import './App.css';
import firebase from "firebase";

import Home from './pages/Home';
import Login from './pages/Login';

function App() {
  const [signedIn, setSignedIn] = useState(false);

  useEffect(() => {
    firebase.auth().onAuthStateChanged((user) => {
      setSignedIn(!!user);
      if(!!user) {
        const messaging = firebase.messaging();
        messaging.getToken({ 
          vapidKey: "BHPrdckByWq-dmOjU3C8ND2bqCuEWToL56Nzud-um4QQ7N1F0x9H_bX0VqwK2WwGDru8m1CM1q04mBe5alS0asc" 
        }).then((currentToken) => {
          if (currentToken) {
            firebase
            .firestore()
            .collection("tokens")
            .doc(user.uid)
            .set({
                webToken: currentToken
            })
            .then(() => {
              console.log("Token successfully written!");
            })
            .catch((error) => {
                console.error("Error writing token: ", error);
            });
          } else {
            // Show permission request UI
            console.log('No registration token available. Request permission to generate one.');
            Notification.requestPermission().then((permission) => {
              if (permission === 'granted') {
                console.log('Notification permission granted.');
                // Send the token to your server and update the UI if necessary
              } else {
                console.log('Unable to get permission to notify.');
              }
            });
          }
        }).catch((err) => {
          console.log('An error occurred while retrieving token. ', err);
          // ...
        });
      }
    });
  }, []);

  return (
    <div className="App">
      {signedIn ? <Home /> : <Login />}
    </div>
  );
}

export default App;
