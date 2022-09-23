import { useEffect } from "react";
import firebase from "firebase";

import TimeList from "../components/TimesList";
import TimeForm from "../components/TimeForm";

const DEFAULT_IMAGE = "https://icons-for-free.com/iconfiles/png/512/clock+minute+time+timer+watch+icon-1320086045717163975.png";

function Home() {

  useEffect(() => {
    const messaging = firebase.messaging();

    messaging.onMessage((payload) => {
      console.log('Message received. ', payload);
      const text = `HEY! "${payload.data.message}`;
      new Notification('New timer', { body: text, icon: DEFAULT_IMAGE });
    });
  }, [])

  return (
    <>
      <div className="header">
        <h1>Welcome to Time Tracker, {firebase.auth().currentUser.displayName}!</h1>
        <button onClick={() => firebase.auth().signOut()}>Sign out</button>
      </div>
      <TimeList />
      <TimeForm />
    </>
  );
}

export default Home;
