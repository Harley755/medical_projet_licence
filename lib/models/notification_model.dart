import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiveNotification {
  final String notificationId;
  final String title;
  final String body;
  final bool isRead;
  final Timestamp timeStamp;

  const ReceiveNotification({
    required this.notificationId,
    required this.title,
    required this.body,
    required this.isRead,
    required this.timeStamp,
  });

  Map<String, dynamic> toJson() => {
        'notificationId': notificationId,
        'title': title,
        'body': body,
        'isRead': false,
        'timeStamp': timeStamp,
      };

  static ReceiveNotification fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ReceiveNotification(
      notificationId: snapshot['notificationId'],
      title: snapshot['title'],
      body: snapshot['body'],
      isRead: snapshot['isRead'],
      timeStamp: snapshot['timeStamp'],
    );
  }
}
