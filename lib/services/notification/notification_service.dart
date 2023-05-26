import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:medical_projet/models/notification_model.dart' as model;
import 'package:medical_projet/services/notification/utils/constants.dart';

class NotificationServices {
  // void requestPermission() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     log("User granted permission");
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     log("User granted provisionnal permission");
  //   } else {
  //     log("User declined or has not accepted permission");
  //   }
  // }

  // void sendPushNotification(String token, String body, String title) async {
  //   try {
  //     await http.post(
  //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Authorization':
  //             'key =AAAAvpwMcj8:APA91bH3XE6JiIA0cr-hIDBpdNfLjQf42eEq2r_UVXtkKvUG6htr-NuxngW1jbnEDaKUbIhgOEdevzWM3hUhMvQCop542JZRVOD3tvZvyIY4NIo9rz8r16tViYCIsORS73ROZqflNGYz'
  //       },
  //       body: jsonEncode(
  //         <String, dynamic>{
  //           "to": token,
  //           "priority": 'high',
  //           "data": <String, dynamic>{
  //             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //             'statut': 'done',
  //             'body': body,
  //             'title': title,
  //           },
  //           "notification": <String, dynamic>{
  //             'title': title,
  //             'body': body,
  //           },
  //         },
  //       ),
  //     );
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<void> sendNotificationToUser({
    required String token,
    required String title,
    required String body,
  }) async {
    String serverKey = Constants.keyServer;
    String url = 'https://fcm.googleapis.com/fcm/send';

    Map<String, dynamic> data = {
      'to': token,
      'notification': {
        'title': title,
        'body': body,
      },
    };

    await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(data),
    );
  }

  Future<String> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    log("My token is : $token");
    return token!;
    // FAUT PENSER A SAVETOKEN
  }

  void saveTokenAndId({
    required String collection,
    required String doc,
    required String token,
    required String userId,
  }) async {
    await FirebaseFirestore.instance.collection(collection).doc(doc).set({
      'token': token,
      'userId': userId,
    });
  }

  Future<bool> sendPushNotificationToAdmin({
    required String token,
    required String title,
    required String body,
  }) async {
    String dataNotifications = '{ "to" : "$token",'
        ' "notification" : {'
        ' "title":"$title",'
        '"body":"$body"'
        ' }'
        ' }';

    await http.post(
      Uri.parse(Constants.baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key= ${Constants.keyServer}',
      },
      body: dataNotifications,
    );
    return true;
  }

  Future<void> saveNotificationToFirestore({
    required String notificationId,
    required String title,
    required String body,
  }) async {
    model.ReceiveNotification receiveNotification = model.ReceiveNotification(
      notificationId: notificationId,
      title: title,
      body: body,
      timeStamp: Timestamp.now(),
    );

    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(notificationId)
        .set(receiveNotification.toJson());
  }
}
