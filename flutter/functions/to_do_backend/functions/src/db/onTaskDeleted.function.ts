import { firestore } from "firebase-functions";
import * as admin from "firebase-admin";

export default firestore
    .document("tasks/{taskId}")
    .onDelete(async (snapshot) => {
        const db = admin.firestore();
        const createTask = snapshot.data();
        const userRef = db.collection("users").doc(createTask.userId);
        await userRef.update({ numberOfTasks: admin.firestore.FieldValue.increment(-1) });
    });