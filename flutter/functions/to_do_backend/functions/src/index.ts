import * as onUserCreated from "./auth/onUserCreated.function";
import * as onTaskCreated from "./db/onTaskCreated.function";
import * as onTaskDeleted from "./db/onTaskDeleted.function";
import * as admin from "firebase-admin";

admin.initializeApp();


export {
    onUserCreated,
    onTaskCreated,
    onTaskDeleted,
};