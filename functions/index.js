const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.sendNotification = functions.firestore.document("activities/{doc_id}").onWrite((change, context) => {
    const document = change.after.exists ? change.after.data() : null;

    if (document === null) {
        return console.log("Document " + context.params.doc_id + ": was deleted");
    }

    const payload = {
        notification: {
            title: "New Activity Detected",
            body: "A suspected activity has been detected at Forest #1",
            icon: "default",
            sound: "default",
            click_action: "FLUTTER_NOTIFICATION_CLICK",
            tag: context.params.doc_id,
            android_channel_id: "Detected Activities"
        },
        data: {
            title: "New Activity Detected",
            body: "A suspected activity has been detected at Forest #1",
            icon: "default",
            sound: "default",
            click_action: "FLUTTER_NOTIFICATION_CLICK",
            tag: context.params.doc_id,
            android_channel_id: "Detected Activities"
        },
    };

    return admin.messaging().sendToTopic("activities", payload).then(results => {
        return console.log("Notification  sent to everyone");
    }).catch(e => {
        console.log("Notification not sent: " + e);
    });
});
