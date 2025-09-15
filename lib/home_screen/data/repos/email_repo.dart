import 'package:balad/home_screen/data/web_services/email_web_services.dart';

class EmailRepo {
  final EmailWebServices emailWebServices;

  EmailRepo(this.emailWebServices);

  Future<bool> sendEmail({
    required String userName,
    required String userEmail,
    required String userSubject,
    required String userMessage,
  }) async {
    return await emailWebServices.sendEmail(
      userName: userName,
      userEmail: userEmail,
      userSubject: userSubject,
      userMessage: userMessage,
    );
  }
}
