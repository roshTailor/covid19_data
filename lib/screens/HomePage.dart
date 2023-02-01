import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:covid19_data/function/http_function.dart';
import 'package:flutter/material.dart';
import '../model/country_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpService httpService = HttpService();
  TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        minimum: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: FutureBuilder(
          future: httpService.getCountryData(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              List<Country> data = snapShot.data!;
              return Column(
                children: [
                  CustomDropdown.search(
                    hintText: 'Select Country',
                    items: [
                      ...data!.map((Country e) => e.country.toString()).toList(),
                    ],
                    controller: countryController,
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
