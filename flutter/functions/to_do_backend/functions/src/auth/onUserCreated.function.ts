import { auth } from "firebase-functions";
import * as admin from "firebase-admin";

export default auth
    .user()
    .onCreate(async (user) => {
        const firestore = admin.firestore();

        const userDoc = firestore.collection("users").doc(user.uid);
        await userDoc.set({
            id: user.uid,
            email: user.email,
            numberOfTasks: 0,
        });
    });
