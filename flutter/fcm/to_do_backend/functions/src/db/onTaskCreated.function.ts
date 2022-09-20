import { firestore } from "firebase-functions";
import * as admin from "firebase-admin";

export default firestore
    .document("tasks/{taskId}")
    .onCreate(async (snapshot) => {
        const db = admin.firestore();
        const createTask = snapshot.data();
        const userRef = db.collection("users").doc(createTask.userId);
        await userRef.update({ numberOfTasks: admin.firestore.FieldValue.increment(1) });

        /// Send notification
        const userDoc = await userRef.get();

        const user = userDoc.data();

        const message = {
            android: {
                notification: {
                    channelId: "high_importance_channel",
                },
            },
            notification: {
                title: "New task",
                body: `The task ${createTask.name} has been created`,
            },
            token: user?.notificationToken,
        };

        await admin.messaging().send(message);
    });