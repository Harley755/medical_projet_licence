import 'dart:developer';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailService {
  Future<String> sendEmailToUser({
    required String userEmail,
    required String adminEmail,
    required String password,
    required String text,
  }) async {
    String response = "";
    final smtpServer = gmail(userEmail, password);
    // Remplacez 'your-email@gmail.com' et 'your-password' par vos propres identifiants de messagerie.

    final message = Message()
      ..from = Address(adminEmail)
      ..recipients.add(userEmail)
      ..subject = 'Votre demande de création de compte'
      ..text = text;

    try {
      final sendReport = await send(message, smtpServer);
      log('E-mail envoyé avec succès : ${sendReport.toString()}');
      response = sendReport.toString();
    } on MailerException catch (e) {
      log('Message not sent.');
      for (var p in e.problems) {
        log('Problem: ${p.code}: ${p.msg}');
        response = 'Problem: ${p.code}: ${p.msg}';
      }
    }
    return response;
  }
}
