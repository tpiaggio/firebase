"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const firebase_functions_1 = require("firebase-functions");
const admin = require("firebase-admin");
exports.default = firebase_functions_1.firestore
    .document("tasks/{taskId}")
    .onDelete(async (snap, _) => {
    const createTask = snap.data();
    const db = admin.firestore();
    const userRef = db.collection("users").doc(createTask.userId);
    await userRef.update({ numberOfTasks: admin.firestore.FieldValue.increment(-1) });
});
//# sourceMappingURL=onTaskDeleted.function.js.map