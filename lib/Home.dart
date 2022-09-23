import 'dart:convert';
import 'dart:io';

import 'package:demoapi/CreateProfile.dart';
import 'package:demoapi/ViewProfile.dart';

import 'package:demoapi/check.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  String error = "";

  List subList = [];

  @override
//   void initState() {
// // TODO: implement initState
//     super.initState();

//     getLeaveData();
//   }

  Future<void> getLeaveData() async {
    var data = {
      "name": "Khalid",
    };
// Starting App API Call.
    var response = await http
        .post(Uri.parse("https://projmy.000webhostapp.com/demo_api_exits.php"),
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const check()));
    } else {
      setState(() {
        isLoading = false;
        error = "Student Class is not valid in the list";
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Createprofile()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.teal,
      body: Container(
        margin: EdgeInsets.all(30),
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          minimumSize: const Size(330, 50)),
                      child: const Text(
                        'REGISTER RECORD',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Createprofile()));
                        setState(() {
                          getLeaveData();
                          isLoading = true;
                          //PicInsert();
                        });
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          minimumSize: const Size(330, 50)),
                      child: const Text(
                        'VIEW RECORD',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => View()));
                        setState(() {
                          isLoading = true;
                          //PicInsert();
                        });
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
