// Import and configure the Firebase SDK
// These scripts are made available when the app is served or deployed on Firebase Hosting
// If you do not serve/host your project using Firebase Hosting see https://firebase.google.com/docs/web/setup
importScripts('/__/firebase/9.2.0/firebase-app-compat.js');
importScripts('/__/firebase/9.2.0/firebase-messaging-compat.js');
importScripts('/__/firebase/init.js');

/**
 * Here is is the code snippet to initialize Firebase Messaging in the Service
 * Worker when your app is not hosted on Firebase Hosting.
 // Give the service worker access to Firebase Messaging.
 // Note that you can only use Firebase Messaging here. Other Firebase libraries
 // are not available in the service worker.

 // Initialize the Firebase app in the service worker by passing in
 // your app's Firebase config object.
 // https://firebase.google.com/docs/web/setup#config-object
 **/
 importScripts('https://www.gstatic.com/firebasejs/9.2.0/firebase-app-compat.js');
 importScripts('https://www.gstatic.com/firebasejs/9.2.0/firebase-messaging-compat.js');

 firebase.initializeApp({
  apiKey: "AIzaSyBY0y7adhWArVXBiFeyCvw0i5VV5RHzOwo",
  authDomain: "time-entries-12b5d.firebaseapp.com",
  projectId: "time-entries-12b5d",
  storageBucket: "time-entries-12b5d.appspot.com",
  messagingSenderId: "705048205294",
  appId: "1:705048205294:web:ab1468dbfa3a99450560ff",
  databaseURL: "https://time-entries-12b5d-default-rtdb.firebaseio.com/",
  measurementId: "G-CP628CHRQB"
});
// Retrieve an instance of Firebase Messaging so that it can handle background
// messages.
const messaging = firebase.messaging();


// If you would like to customize notifications that are received in the
// background (Web app is closed or not in browser focus) then you should
// implement this optional method.
// Keep in mind that FCM will still show notification messages automatically 
// and you should use data messages for custom notifications.
// For more info see: 
// https://firebase.google.com/docs/cloud-messaging/concept-options
messaging.onBackgroundMessage(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  // Customize notification here
  const notificationTitle = 'Background Message Title';
  const notificationOptions = {
    body: payload.data.message,
    icon: '/firebase-logo.png'
  };

  self.registration.showNotification(notificationTitle,
    notificationOptions);
});