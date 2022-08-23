import { useEffect, useState } from 'react';
import firebase from "firebase/app";

const TimesList = () => {
  const [times, setTimes] = useState([]);

  useEffect(() => {
    const timesRef = firebase.database().ref("times");
    timesRef.on("value", (snapshot) => {
      const timesObj = snapshot.val();
      const newTimes = Object.keys(timesObj).map(id => ({
        id,
        ...timesObj[id]
      }));
      setTimes(newTimes);
    });
    return () => timesRef.off();
  },[]);

  const handleDelete = id => {
      firebase.database().ref(`times/${id}`).remove();
  }

  return (
      <div>
          <h2>Times List</h2>
          <ol>
              {times.map(time => (
                  <li key={time.id}>
                      <div className="time-entry">
                        {time.title}
                        <code className="time">{time.time_seconds}</code>
                        <button onClick={() => handleDelete(time.id)}>Delete</button>
                      </div>
                  </li>
              ))}
          </ol>
      </div>
  );
};

export default TimesList;