"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const firebase_functions_1 = require("firebase-functions");
const admin = require("firebase-admin");
exports.default = firebase_functions_1.auth.user().onCreate(async (user, _) => {
    const db = admin.firestore();
    const userRef = db.collection("users").doc(user.uid);
    await userRef.set({
        email: user.email,
        numberOfTasks: 0,
    });
});
//# sourceMappingURL=onUserCreate.function.js.map