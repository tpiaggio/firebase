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
    });
  }, []);

  return (
    <div className="App">
      {signedIn ? <Home /> : <Login />}
    </div>
  );
}

export default App;
