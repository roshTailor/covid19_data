import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:covid19_data/function/http_function.dart';
import 'package:covid19_data/utils/ApiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/country_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpService httpService = HttpService();

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
              print(data[0].country);
              return Column(
                children: [
                  CustomDropdown.search(
                    hintText: 'Select Country',
                    items: [
                      ...data.map((Country e) => e.country.toString()).toList(),
                    ],
                    controller: ApiString.countryController,
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var widget = Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ExpansionTile(
                            leading: SizedBox(
                                width: 50,
                                child: Image.network(
                                  "${data[index].countryInfo!.flag}",
                                )),
                            tilePadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            title: Text(
                              "${data[index].country}",
                            ),
                            expandedAlignment: Alignment.centerLeft,
                            childrenPadding: const EdgeInsets.all(10),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  ApiString.countryController.text =
                                      data[index].country.toString();
                                  Navigator.pushNamed(context, 'state');
                                });
                              },
                              child: const Icon(
                                CupertinoIcons.info,
                                color: Colors.black,
                              ),
                            ),
                            children: [
                              Text("Total Cases : ${data[index]}"),
                              Text("Today Cases : ${data[index].todayCases}"),
                              Text("Active Cases : ${data[index].active}"),
                              Text(
                                  "Critical Cases : ${data[index].critical}"),
                              Text("Total Deaths : ${data[index].deaths}"),
                              Text(
                                  "Today Deaths : ${data[index].todayDeaths}"),
                              Text(
                                  "Total Recovered : ${data[index].recovered}"),
                              Text(
                                  "Today Recovered : ${data[index].todayRecovered}"),
                              Text("Tests : ${data[index].tests}"),
                              Text("Continent : ${data[index].continent}"),
                            ],
                          ),
                        );
                        if (ApiString.countryController.text != '') {
                          if (data[index].country!.contains(
                              ApiString.countryController.text)) {
                            return widget;
                          }
                        } else {
                          return widget;
                        }
                        return Container();
                      },
                    ),
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
