import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/components/conservsation/admin_picture_name.dart';
import 'package:medical_projet/size_config.dart';

class AdminDetailConversation extends StatefulWidget {
  static String routeName = "/admin/chat/details";
  const AdminDetailConversation({super.key});

  @override
  State<AdminDetailConversation> createState() =>
      _AdminDetailConversationState();
}

class _AdminDetailConversationState extends State<AdminDetailConversation> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {},
          child: const AdminPictureName(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.info_outline,
              color: kPrimaryColor,
              size: 26.0,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: getProportionateScreenHeight(45),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                backgroundImage: NetworkImage(
                  "https://i.pinimg.com/736x/08/2a/1b/082a1bb32a158d7270582c044fca7bfd.jpg",
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 8.0),
                  child: Stack(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(30),
                          ),
                          hintText: "Ecrire...",
                          border: InputBorder.none,
                        ),
                      ),
                      Positioned(
                        right: 0.0,
                        bottom: -3.0,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.insert_emoticon,
                            size: 30.0,
                            color: kPrimaryColor.withOpacity(.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kPrimaryColor,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.mic_rounded),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
