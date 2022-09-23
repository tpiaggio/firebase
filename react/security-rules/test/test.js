const firebase = require("@firebase/testing");

const MY_PROJECT_ID = "time-entries-12b5d";

const myAuth = { uid: "alice", email: "alice@example.com" };

function getFirestore(auth) {
    return firebase.initializeTestApp({ projectId: MY_PROJECT_ID, auth: auth}).firestore();
}

const aliceDoc = {
  title: "Test",
  time_seconds: 100,
  user_id: "alice"
}

const timeDoc = {
    title: "Test",
    time_seconds: 100,
    user_id: "abc"
}

describe("Time Entry", () => {
  it("Cannot read items from any collection", async () => {
      const db = getFirestore(null);
      const testDoc = db.collection("test").doc("testDoc");
      await firebase.assertFails(testDoc.get());
  });

  it("Cannot read items from times collection if not authenticated", async () => {
    const db = getFirestore(null);
    const testDoc = db.collection("times").doc("testDoc");
    await firebase.assertFails(testDoc.get());
  });

  it("Cannot read items from times collection if authenticated but is not owner", async () => {
    const dbAdmin = firebase.initializeAdminApp({ projectId: "time-entries-12b5d", auth: myAuth }).firestore();
    const testAdminRef = dbAdmin.collection("times").doc("timesDoc");
    await testAdminRef.set(timeDoc);
    const db = getFirestore(myAuth);
    const testDoc = db.collection("times").doc("timesDoc");
    await firebase.assertFails(testDoc.get());
    await testAdminRef.delete();
  });

  it("Can read items from times collection if authenticated and is owner", async () => {
    const dbAdmin = firebase.initializeAdminApp({ projectId: "time-entries-12b5d", auth: myAuth }).firestore();
    const testAdminRef = dbAdmin.collection("times").doc("timesDoc");
    await testAdminRef.set(aliceDoc);
    const db = getFirestore(myAuth);
    const testDoc = db.collection("times").doc("timesDoc");
    await firebase.assertSucceeds(testDoc.get());
    await testAdminRef.delete();
  });

  it("Cannot create items from times collection if not authenticated", async () => {
    const db = getFirestore(null);
    const testRef = db.collection("times").doc("testDoc");
    await firebase.assertFails(testRef.set(timeDoc));
  });

  it("Cannot create items from times collection if uid != user_id", async () => {
    const db = getFirestore(myAuth);
    const testRef = db.collection("times").doc("testDoc");
    await firebase.assertFails(testRef.set(timeDoc));
  });

  it("Can create items from times collection if uid == user_id", async () => {
    const db = getFirestore(myAuth);
    const testRef = db.collection("times").doc("testDoc");
    await firebase.assertSucceeds(testRef.set(aliceDoc));
  });

  it("Cannot create items from times collection if title is empty", async () => {
    const db = getFirestore(myAuth);
    const testRef = db.collection("times").doc("timesDoc");
    const timesInvalid = {
      ...aliceDoc,
      title: "",
    };
    await firebase.assertFails(testRef.set(timesInvalid));
  });

  it("Cannot create items from times collection if time_seconds is not a number", async () => {
    const db = getFirestore(myAuth);
    const testRef = db.collection("times").doc("timesDoc");
    const timesInvalid = {
      ...aliceDoc,
      time_seconds: "test",
    };
    await firebase.assertFails(testRef.set(timesInvalid));
  });

  it("Can delete items from times collection if uid == user_id", async () => {
    const db = getFirestore(myAuth);
    const testRef = db.collection("times").doc("timesDoc");
    await testRef.set(aliceDoc);
    await firebase.assertSucceeds(testRef.delete());
  });

  it("Cannot delete items from times collection if uid != user_id", async () => {
    const dbAdmin = firebase.initializeAdminApp({ projectId: "time-entries-12b5d", auth: myAuth }).firestore();
    const testAdminRef = dbAdmin.collection("times").doc("timesDoc");
    await testAdminRef.set(timeDoc);
    const db = getFirestore(myAuth);
    const testRef = db.collection("times").doc("timesDoc");
    await firebase.assertFails(testRef.delete());
  });

});

