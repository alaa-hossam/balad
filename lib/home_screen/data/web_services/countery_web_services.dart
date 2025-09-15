import '../../../constants/strings.dart';
import '../models/country.dart';
import 'package:dio/dio.dart';

class CounteryWebServices {
  late Dio dio;
  CounteryWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: counteryBaseUrl,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<String>> getAllcountriesNames() async {
    try {
      Response response = await dio.get('all?fields=name');
      List<dynamic> data = response.data;
      List<String> countries = data
          .map((item) => item["name"]["common"].toString())
          .toList();
      return countries;
    } catch (e) {
      return [];
    }
  }

  Future<List<Country>> getCountry(String countryName) async {
  try {
    Response response = await dio.get('name/$countryName');
    if (response.data is List) {
      return (response.data as List)
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

}
