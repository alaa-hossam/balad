import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/country.dart';
import '../../data/repos/countery_repo.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  final CounteryRepo countryRepo;

  CountryCubit(this.countryRepo) : super(CountryInitial());

  /// Fetch all country names
  Future<void> getAllCountriesName() async {
    emit(CountryLoading());
    try {
      final countriesName = await countryRepo.getAllCountriesName();
      emit(CountriesNameLoaded(countriesName));
    } catch (e) {
      emit(CountryError("Failed to fetch countries: $e"));
    }
  }

  Future<Country?> getCountry(String name) async {
  try {
    emit(CountryLoading());
    final country = await countryRepo.getCountry(name);
    emit(CountryLoaded(country));
    return country;
  } catch (e) {
    emit(CountryError(e.toString()));
    return null;
  }
}

}
