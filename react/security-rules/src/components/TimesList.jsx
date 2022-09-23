import { useEffect, useState } from 'react';
import firebase from "firebase/app";

const DEFAULT_IMAGE = "https://icons-for-free.com/iconfiles/png/512/clock+minute+time+timer+watch+icon-1320086045717163975.png";

const TimesList = () => {
  const [times, setTimes] = useState([]);

  useEffect(() => {
    const timesRef = firebase
      .firestore()
      .collection("times")
      .where("user_id", "==", firebase.auth().currentUser.uid);
    
    const unsubscribe = timesRef.onSnapshot((snapshot) => {
      var newTimes = [];
      snapshot.forEach((doc) => {
        newTimes.push({
          id: doc.id,
          ...doc.data()
        });
      });
      setTimes(newTimes);
    });
    return () => unsubscribe();
  },[]);

  const handleDelete = (id, imagePath) => {
    firebase.firestore().collection("times").doc(id).delete();
    firebase.storage().ref(imagePath).delete();
  }

  const getWeather = weather => {
    if(!weather) return;
    const metric = weather.metric === "celsius" ? "°C" : "°F";
    return weather.temperature ? weather.sky + " " + parseInt(weather.temperature) + metric : "-";
  }

  return (
      <div>
          <h2>Times List</h2>
          <ol>
              {times.map(time => (
                  <li key={time.id}>
                      <div className="time-entry">
                        <span><img height="50" width="50" src={time.imageUrl || DEFAULT_IMAGE} /></span>
                        <span>{time.title}</span>
                        <span>{time.location}</span>
                        <span>{getWeather(time.weather)}</span>
                        <code className="time">{time.time_seconds}</code>
                        <button onClick={() => handleDelete(time.id, time.imagePath)}>Delete</button>
                      </div>
                  </li>
              ))}
          </ol>
      </div>
  );
};

export default TimesList;