import '../../../constants/strings.dart';
import 'package:dio/dio.dart';

class NewsWebServices {
  late Dio dio;
  NewsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: newsBaseUrl,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCountryNews(String cca2) async {
    try {
      const String apiKey = "77deea9707814500a17eb0c80af7e070";

      Response response = await dio.get(
        'search-news',
        queryParameters: {
          "api-key": apiKey,
          "source-countries": cca2, 
        },
      );
      List<dynamic> data = response.data['news'] ?? [];
      return data;
    } catch (e) {
      print("Error fetching news: $e");
      return [];
    }
  }
}
