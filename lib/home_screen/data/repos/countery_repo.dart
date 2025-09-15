import '../models/country.dart';
import '../web_services/countery_web_services.dart';

class CounteryRepo {
  final CounteryWebServices counteryWebServices;

  CounteryRepo(this.counteryWebServices);

  Future<List<String>> getAllCountriesName() async {
    return await counteryWebServices.getAllcountriesNames();
  }

  Future<Country> getCountry(String countryName) async {
    final countries = await counteryWebServices.getCountry(countryName);

    if (countries.isNotEmpty) {
      return countries.first;
    } else {
      throw Exception("No country found for $countryName");
    }
  }
}
