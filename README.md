# Forest Guard

The mobile app client for the [Forest Guard AI Model](https://github.com/LISA-Ghana/forest_guard_ai) built and deployed by Team LISA for the [AI4Good Hackathon](https://superfluid.io/ai-commons/) organized by [AI Commons](https://ai-commons.org/) and moderated by [Superfluid.io](https://superfluid.io/).

> ### The purpose of the app is to receive notifications triggered by the cloud functions upon data sent to Firestore by the Raspberry Pi running the AI Model.

## How It Works
The Keras model deployed on the Raspberry Pi detects audio and make predictions. It sends the data (`{type: "1"}`) for a Firestore collection (`activities`). The cloud function is then triggered with either sends notification to the mobile devices or does nothing based on the `type`.
```
"1" => Illegal Activity (Chainsaw, etc)
"2" => Human Activities
"<any other number>" => Irrelevant activity (birds chipping, wind, etc)
```

## Requirements
* [Flutter](https://flutter.dev) for building the application.
* [Google Maps API Key](https://cloud.google.com/maps-platform/) to the Map.
* [Tomtom API Key](https://developer.tomtom.com/routing-api) for Map routes.
* [Firebase Project](https://firebase.google.com) for the database and hosting cloud functions.
* [Firebase CLI](https://firebase.google.com/docs/functions/get-started) for setting up, testing and deploying the cloud functions (which trigger notifications).

## Set Up (Firebase for Flutter)
1. Follow [this](https://firebase.flutter.dev/docs/overview) to set up Firebase for Flutter. Remember to add your `google-services.json` (for android) and `GoogleService-Info.plist` for (iOS).
2. Replace `android:value` of this meta tag within the `<application>` tag inside the `android/app/src/main/AndroidManifest.xml` with your Google Maps API Key.
```xml
<meta-data android:name="com.google.android.geo.API_KEY" 
          android:value="your_long_random_maps_api_key"/>
```

## Set Up (Cloud Functions)
1. Run `firebase login` to connect your google account with the Firebase CLI. (Be sure to use the same account used for the Firebase Project as they will be sharing the same database)
2. After installing the Firebase CLI, run `firebase init functions` from the project root. Follow the instructions to complete the initialization. (Note: the function script was written in **JavaScript** not TypeScript).
If you get an NPM permission or access denied error, run `cd functions && sudo npm install`.
3. Run `firebase deploy --only functions` to deploy the script to Firebase. Upon smooth sailing, you will see a success message like **✔  Deploy complete!** in the console.

## Set Up (Firebase Firestore)
1. After setting up a firebase project, set up Cloud Firestore.
2. Set up a collection `agents` and add a document with:
```json
{
    "agent_id": "1234",
    "forest_id": "1"
}
```
> #### Note: You should allow read in your firebase rules for non-authenticated calls to this `agents` collection. The document existence is checked before performing the anonymous login. You can change this before in the `lib/auth_service.dart`.

#### Sample Firestore Rules
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
    
    match /agents/{id} {
    	allow read;
        allow write: if false;
    }
  }
}
``` 

## Team Members

| Name | Role | Profile |  
| :--- | :--- | :--- |  
| Appau Ernest (Lead) | AI Model Development/Deployment | [Github](https://github.com/kappernie) / [LinkedIn](https://www.linkedin.com/in/appauernestkofimensah/) |  
| Debrah Kwesi Buabeng | Mobile Developer | [Github](https://github.com/Akora-IngDKB) / [LinkedIn](https://www.linkedin.com/in/kwesi-buabeng-debrah) |  
| Akpalu Larry | Data Collection and Annotation | [Github](https://github.com/larry2310) / [LinkedIn](https://www.linkedin.com/in/larry-akpalu-5b3a1a119/) |  
| Kpene Godsway Edem | Documentation | [Github](https://github.com/kpegods96) / [LinkedIn](https://www.linkedin.com/in/godsway-edem-kpene-a6542711a/) |  
| Baidoo Mabel | Data Collection and Annotation | [Github](https://github.com/GeekiAdubea) / [LinkedIn](https://www.linkedin.com/in/mabel-adubea-baidoo/) |  
| Appau Roberta | UI/UX Designer | N/A |  
