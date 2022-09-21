import { useState } from 'react';
import firebase from "firebase/app";

const LOADING_IMAGE_URL = "https://www.google.com/images/spin-32.gif?a";

const TimeForm = () => {
    const [title, setTitle] = useState("");
    const [time, setTime] = useState(0);
    const [location, setLocation] = useState("");
    const [file, setFile] = useState();

    const handleSubmit = e => {
        e.preventDefault();

        firebase
        .firestore()
        .collection("times")
        .add({
            title, 
            time_seconds: parseInt(time),
            location,
            imageUrl: !!file ? LOADING_IMAGE_URL : null,
            user_id: firebase.auth().currentUser.uid
        })
        .then((timesRef) => {
            setTitle("");
            setTime(0);
            setLocation("");
            if(!file) return;
            const filePath = firebase.auth().currentUser.uid + "/" + timesRef.id + "/" + file.name;
            return firebase.storage().ref(filePath).put(file).then((snapshot) => {
              return snapshot.ref.getDownloadURL().then((downloadUrl) => {
                return timesRef.update({
                  imageUrl: downloadUrl,
                  imagePath: snapshot.metadata.fullPath
                });
              });
            })
        });
    }

    return (
        <form onSubmit={handleSubmit}>
            <h4>Add Time Entry</h4>
            <div>
                <label>Title</label>
                <input type="text" value={title} onChange={e => setTitle(e.currentTarget.value)} />
            </div>
            <div>
                <label>Time</label>
                <input type="number" value={time} onChange={e => setTime(e.currentTarget.value)} />
            </div>
            <div>
                <label>Location</label>
                <input type="text" value={location} onChange={e => setLocation(e.currentTarget.value)} />
            </div>
            <div>
                <label>Image</label>
                <input type="file" accept="image/*" onChange={e => setFile(e.target.files[0])} />
            </div>
            <button>Add Time Entry</button>
        </form>
    )
};

export default TimeForm;