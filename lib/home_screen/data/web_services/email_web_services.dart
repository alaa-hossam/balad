import 'package:dio/dio.dart';

class EmailWebServices {
  late Dio dio;
  EmailWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://api.emailjs.com/api/v1.0/email/",
      receiveDataWhenStatusError: true,
      headers: {
        "origin": "http://localhost", // required by EmailJS
        "Content-Type": "application/json",
      },
    );
    dio = Dio(options);
  }

  Future<bool> sendEmail({
    required String userName,
    required String userEmail,
    required String userSubject,
    required String userMessage,
  }) async {
    const serviceId = "service_sxdqq7g";
    const templateId = "template_egc689a";
    const userId = "Ao_Y57UYvqylnboF9";

    try {
      final response = await dio.post(
        "send",
        data: {
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": userId,
          "template_params": {
            "user_name": userName,
            "user_email": userEmail,
            "user_subject": userSubject,
            "user_message": userMessage,
          }
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Send email error: $e");
      return false;
    }
  }
}
