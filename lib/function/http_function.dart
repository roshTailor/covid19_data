import 'dart:convert';

import 'package:covid19_data/utils/ApiUtils.dart';
import 'package:http/http.dart';

import '../model/country_model.dart';

class HttpService {
  Future<List<Country>> getCountryData() async {
    Response response = await get(Uri.parse(ApiString.countryUrl));
    print(response.statusCode);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<Country> countryData = data.map((e) => Country.fromJson(e)).toList();
      return countryData;
    } else {
      throw "no data found";
    }
  }
}

/*Future<List<User>> getPosts() async {
    Response res = await get(Uri.parse(postsURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<User> posts = body
          .map(
            (dynamic item) => User.fromJson(item),
      )
          .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }*/
