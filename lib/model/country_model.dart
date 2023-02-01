// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

List<Country> countryFromJson(String str) => List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String countryToJson(List<Country> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
  Country({
    this.country,
    this.slug,
    this.iso2,
  });

  String? country;
  String? slug;
  String? iso2;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        country: json["Country"],
        slug: json["Slug"],
        iso2: json["ISO2"],
      );

  Map<String, dynamic> toJson() => {
        "Country": country,
        "Slug": slug,
        "ISO2": iso2,
      };
}
