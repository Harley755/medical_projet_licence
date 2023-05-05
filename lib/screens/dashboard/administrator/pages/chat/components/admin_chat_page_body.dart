import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/components/details_conversation.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/components/recent_contact.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/components/search_chat.dart';
import 'package:medical_projet/size_config.dart';

class AdminChatPageBody extends StatefulWidget {
  const AdminChatPageBody({super.key});

  @override
  State<AdminChatPageBody> createState() => _AdminChatPageBodyState();
}

class _AdminChatPageBodyState extends State<AdminChatPageBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(17),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdminSeachChat(),
            SizedBox(height: getProportionateScreenHeight(15.0)),
            RobotoFont(
              title: "Contacts recents",
              size: 17.0,
              color: Colors.black.withOpacity(0.9),
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: getProportionateScreenHeight(15.0)),
            RecentContact(),
            SizedBox(height: getProportionateScreenHeight(15.0)),
            GestureDetector(
              onLongPress: () {},
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AdminDetailConversation.routeName,
                );
              },
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://pfps.gg/assets/pfps/6143-boruto-kawaki.png"),
                ),
                contentPadding: EdgeInsets.all(0),
                title: RobotoFont(
                  title: "John Doe",
                  size: 17.0,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: RobotoFont(
                  title: "Vous: Je vous en prie Monsieur !",
                  size: 13.0,
                ),
                trailing: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 9,
                  backgroundImage: NetworkImage(
                    "https://pfps.gg/assets/pfps/6143-boruto-kawaki.png",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
