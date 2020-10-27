const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.sendNotification = functions.firestore.document("activities/{doc_id}").onWrite((change, context) => {
    const document = change.after.exists ? change.after.data() : null;

    if (document === null) {
        return console.log("Document " + context.params.doc_id + ": was deleted");
    }

    let title = "";

    if (document.type === "1") {
        // Illegal Activity
        title = "Illegal Activity Detected";
        console.log(title);
    } else if (document.type === "2") {
        // Human Activity
        title = "Human Activity Detected";
        console.log(title)
    } else {
        // No activity
        return console.log("No activity detected. Skipping notification");
    }

    const payload = {
        notification: {
            title: title,
            body: "A suspected activity has been detected at Forest #1",
            icon: "default",
            sound: "default",
            click_action: "FLUTTER_NOTIFICATION_CLICK",
            tag: context.params.doc_id,
            android_channel_id: "Detected Activities"
        },
        data: {
            title: title,
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
