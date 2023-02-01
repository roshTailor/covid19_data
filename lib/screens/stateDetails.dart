
import 'package:covid19_data/function/state_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/state_model.dart';


class StateDetail extends StatefulWidget {
  const StateDetail({Key? key}) : super(key: key);

  @override
  State<StateDetail> createState() => _StateDetailState();
}

class _StateDetailState extends State<StateDetail> {
  HttpServiceState httpServiceState = HttpServiceState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back, color: Colors.black,),
        ),
        title: const Text("Covid - 19", style: TextStyle(fontSize: 20, color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // CupertinoSearchTextField(
            //   backgroundColor: Colors.white,
            //   placeholderStyle: GoogleFonts.poppins(color: Colors.grey),
            //   style: GoogleFonts.poppins(),
            //   onChanged: (val){
            //     setState(() {
            //       ApiUtils.searchState.value = val;
            //     });
            //   },
            // ),
            Expanded(
              child: FutureBuilder(
                future: httpServiceState.getStateData(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    List<AllState>? state = snapshot.data;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: state!.length,
                      itemBuilder: (context, index) {
                        var widget = ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ExpansionTile(
                              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                              title: Text("${state[index].province}".substring(9),),
                              subtitle: Text("${state[index].date}".substring(0,10), style: TextStyle(color: Colors.grey),),
                              expandedAlignment: Alignment.centerLeft,
                              childrenPadding: const EdgeInsets.all(10),
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Cases : ${state[index].confirmed}"),
                                Text("Active Case : ${state[index].active}"),
                                Text("Recovered : ${state[index].recovered}"),
                                Text("Deaths : ${state[index].deaths}"),
                              ],
                            ),
                          ),
                        );
                        // if(ApiString.searchState.value != '') {
                        //   if(state[index].province.toString().toUpperCase().contains(ApiUtils.searchState.value.toUpperCase())) {
                        //     return widget;
                        //   }
                        // } else {
                        //   return widget;
                        // }
                        return Container();
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      //backgroundColor: Colors.bgColor,
    );
  }
}