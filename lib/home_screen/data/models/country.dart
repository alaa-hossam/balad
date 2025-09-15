class Country {
  late String name;
  late String flagUrl;
  late String coatOfArmsUrl;
  late bool independent;
  late int population;
  late bool unMember;
  late String timezone;
  late String region;
  late String capital;
  late String cca2;
  late List<Map<String, String>> maps;
  late String startOfWeek;

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name']?['common'] ?? 'Unknown';

    flagUrl = json['flags']?['png'] ?? '';
    coatOfArmsUrl = json['coatOfArms']?['png'] ?? '';

    independent = json['independent'] ?? false;
    population = json['population'] ?? 0;
    unMember = json['unMember'] ?? false;

    if (json['timezones'] != null &&
        json['timezones'] is List &&
        json['timezones'].isNotEmpty) {
      timezone = json['timezones'][0];
    } else {
      timezone = 'Unknown';
    }

    region = json['region'] ?? 'Unknown';

    if (json['capital'] != null &&
        json['capital'] is List &&
        json['capital'].isNotEmpty) {
      capital = json['capital'][0];
    } else {
      capital = 'Unknown';
    }

    cca2 = json['cca2'] ?? '';

    maps = (json['maps'] as Map<String, dynamic>).entries.map((entry) {
      return {"name": entry.key, "url": entry.value.toString()};
    }).toList();

    startOfWeek = json['startOfWeek'] ?? 'Unknown';
  }
}
