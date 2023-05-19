import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/notifications/admin_notification_page.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/search/admin_search_page.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/state/admin_state_page.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/admin_chat_page.dart';

const TextStyle optionStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w600,
);

List<Widget> adminScreenItems = [
  const AdminStatePage(),
  // const AdminChatPage(),
  const AdminSearchPage(),
  const AdminNotificationPage(),
];
