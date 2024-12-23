import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/notifications/account_details/account_details.dart';
import 'package:medical_projet/services/notification/notification_service.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class BodyAdminNotificationPage extends StatelessWidget {
  const BodyAdminNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('notifications').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Une erreur s\'est produite'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        }

        final notifications = snapshot.data!.docs;

        return ListView.builder(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(10.0),
          ),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification =
                notifications[index].data() as Map<String, dynamic>;

            return notification['isRead']
                ? InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AccountDetails(
                          userId: notification['notificationId'],
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimaryColor,
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/User.svg",
                            color: Colors.white,
                          ),
                        ),
                        title: RobotoFont(
                          title: notification['title'],
                          size: getProportionateScreenWidth(18),
                        ),
                        subtitle: Column(
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(5.0),
                            ),
                            Text(notification['body']),
                          ],
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        NotificationServices().updateNotificationToFirestore(
                          notificationId: notification['notificationId'],
                        );
                        return AccountDetails(
                          userId: notification['notificationId'],
                        );
                      }),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // foregroundDecoration: BoxDecoration(
                        //   color: selectTabBg,
                        // ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          color: selectTabBg,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(14.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kPrimaryColor,
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/User.svg",
                                color: Colors.white,
                              ),
                            ),
                            title: RobotoFont(
                              title: notification['title'],
                              size: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.w700,
                            ),
                            subtitle: Column(
                              children: [
                                SizedBox(
                                  height: getProportionateScreenHeight(5.0),
                                ),
                                Text(
                                  notification['body'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}
