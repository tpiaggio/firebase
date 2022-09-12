"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.onTaskDeleted = exports.onTaskCreated = exports.onUserCreated = void 0;
const admin = require("firebase-admin");
admin.initializeApp();
const onUserCreated = require("./auth/onUserCreate.function");
exports.onUserCreated = onUserCreated;
const onTaskCreated = require("./db/onTaskCreated.function");
exports.onTaskCreated = onTaskCreated;
const onTaskDeleted = require("./db/onTaskDeleted.function");
exports.onTaskDeleted = onTaskDeleted;
//# sourceMappingURL=index.js.map