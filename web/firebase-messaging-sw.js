importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');


const firebaseConfig = {
    apiKey: 'AIzaSyAZKaqMlzuy0mSGqPax8Zn8_JPqe-IDXxo',
    appId: '1:779349165108:web:04989177a58413ae7b3661',
    messagingSenderId: '779349165108',
    projectId: 'balaa-e77f5',
    authDomain: 'balaa-e77f5.firebaseapp.com',
    storageBucket: 'balaa-e77f5.appspot.com',
    measurementId: 'G-6S0018VD9P',
};
firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();


messaging.onBackgroundMessage(function (payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
        notificationOptions);
});