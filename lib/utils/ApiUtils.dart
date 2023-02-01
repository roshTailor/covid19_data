import 'package:flutter/cupertino.dart';

class ApiString {
  static String countryUrl = "https://disease.sh/v3/covid-19/countries";
  static String stateUrl = "https://api.covid19api.com/live/country/:country/status/:status";
  static TextEditingController countryController = TextEditingController();
}
