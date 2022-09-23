import 'dart:developer';
import 'dart:io';

import 'package:demoapi/CreateProfile.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AllData extends StatefulWidget {
  String id = '';
  AllData(String id) {
    this.id = id;
  }
  @override
  AllDataAllData createState() => AllDataAllData();
}

class AllDataAllData extends State<AllData> {
  bool isLoading = false;
  String error = "";

  List subList = [];

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    log("plz print");
    getFee(widget.id);
  }

  Future<void> getFee(String id) async {
    var data = {
      "id": id,
    };
// Starting App API Call.
    var response = await http
        .post(
            Uri.parse("https://projmy.000webhostapp.com/demo_api_exits_id.php"),
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
      // subList[0]['id'];
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => AllData(widget.id)));
    } else {
      setState(() {
        isLoading = false;
        error = "Student Class is not valid in the list";
      });
      // SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFBCEBEB),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              itemCount: subList == null ? 0 : subList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
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
                        Text(subList[0]["name"] + " " + widget.id)
                      ]),
                      Row(children: [
                        Text(
                          "hindi :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(subList[0]["hindi"])
                      ]),
                      Row(children: [
                        Text(
                          "english :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(subList[0]["english"].toString())
                      ]),
                      Row(children: [
                        Text(
                          "physics : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(subList[0]["physics"].toString())
                      ]),
                      Row(children: [
                        Text(
                          "chemistry :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(subList[0]["chemistry"].toString())
                      ]),
                      Row(children: [
                        Text(
                          "math :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(subList[0]["math"].toString())
                      ]),
                      Row(children: [
                        Text(
                          "fee :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(subList[0]["fee"].toString())
                      ]),
                      SizedBox(
                        height: 20,
                      )
                    ]),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                );
              },
            ))
          ],
        ));
  }
}
