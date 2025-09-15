part of 'country_cubit.dart';

@immutable
sealed class CountryState {}

final class CountryInitial extends CountryState {}

final class CountryLoading extends CountryState {}

final class CountriesNameLoaded extends CountryState {
  final List<String> countries;
  CountriesNameLoaded(this.countries);
}

final class CountryLoaded extends CountryState {
  final Country country;
  CountryLoaded(this.country);
}

final class CountryError extends CountryState {
  final String message;
  CountryError(this.message);
}
