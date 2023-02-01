import 'dart:convert';

import 'package:http/http.dart';

import '../model/state_model.dart';
import '../utils/ApiUtils.dart';

class HttpServiceState{
  Future<List<AllState>> getStateData() async {
    Response response = await get(Uri.parse(ApiString.countryUrl));
    print(response.statusCode);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<AllState> stateData = data.map((e) => AllState.fromJson(e)).toList();
      return stateData;
    } else {
      throw "no data found";
    }
  }
}