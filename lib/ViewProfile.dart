import 'dart:io';

import 'package:demoapi/AllData.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class View extends StatefulWidget {
  String id = '';
  AllData(String id) {
    this.id = id;
  }

  View({Key? key}) : super(key: key);
  @override
  ViewHome createState() => ViewHome();
}

class ViewHome extends State<View> {
  bool isLoading = false;
  String error = "";

  List subList = [];
  late int month;
  late int s_month = 0;

  @override
  void initState() {
// TODO: implement initState

    DateTime d = DateTime.now();
    month = d.month;

    if (month >= 4 && month <= 12)
      s_month = month - 3;
    else
      s_month = month + 9;

    print("School Month:${s_month}");
    super.initState();

    getLeaveData();
  }

  Future<void> getLeaveData() async {
    var data = {
      "class": "",
    };
// Starting App API Call.
    var response = await http
        .post(Uri.parse("https://projmy.000webhostapp.com/demo_api_view.php"),
            body: json.encode(data))
        .catchError((e) {
      if (e is SocketException) print("No internet connection");
      setState(() {
        error = "";
        isLoading = false;
      });
    });
// Getting Server response into variable.
    var obj = jsonDecode(response.body);

    if (obj["result"] == "S") {
      setState(() {
        error = "";
        isLoading = false;
        subList = obj["data"];
      });
    } else {
      setState(() {
        isLoading = false;
        error = "Student Class is not valid in the list";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFBCEBEB),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                "Name and fee",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: subList == null ? 0 : subList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: int.parse(subList[index]['fee']) == 0
                      ? Colors.red
                      : (int.parse(subList[index]['fee']) >= 0 &&
                              int.parse(subList[index]['fee']) <= 10000)
                          ? Colors.orange
                          : (int.parse(subList[index]['fee']) > 10000 &&
                                  int.parse(subList[index]['fee']) <= 20000)
                              ? Colors.yellow
                              : Colors.green,
                  child: ListTile(
                    title: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        Text(
                          "name :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(subList[index]["name"] + " " + widget.id)
                      ]),
                      // Row(children: [
                      //   Text(
                      //     "hindi :",
                      //     style: TextStyle(fontWeight: FontWeight.bold),
                      //   ),
                      //   Text(subList[index]["hindi"])
                      // ]),
                      // Row(children: [
                      //   Text(
                      //     "english :",
                      //     style: TextStyle(fontWeight: FontWeight.bold),
                      //   ),
                      //   Text(subList[index]["english"])
                      // ]),
                      // Row(children: [
                      //   Text(
                      //     "physics : ",
                      //     style: TextStyle(fontWeight: FontWeight.bold),
                      //   ),
                      //   Text(subList[index]["physics"].toString())
                      // ]),
                      // Row(children: [
                      //   Text(
                      //     "chemistry :",
                      //     style: TextStyle(fontWeight: FontWeight.bold),
                      //   ),
                      //   Text(subList[index]["chemistry"].toString())
                      // ]),
                      // Row(children: [
                      //   Text(
                      //     "math :",
                      //     style: TextStyle(fontWeight: FontWeight.bold),
                      //   ),
                      //   Text(subList[index]["math"].toString())
                      // ]),
                      Row(children: [
                        Text(
                          "fee :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(subList[index]["fee"].toString())
                      ]),
                      SizedBox(
                        height: 20,
                      )
                    ]),
                    onTap: () {
                      if (subList[index]['fee'] != "0")
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AllData(subList[index]["id"].toString())));

                      {}
                    },
                  ),
                );
              },
            ))
          ],
        ));
  }
}
