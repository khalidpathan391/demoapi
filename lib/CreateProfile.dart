import 'dart:convert';
import 'dart:developer';

import 'package:demoapi/ViewProfile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Createprofile extends StatefulWidget {
  const Createprofile({Key? key}) : super(key: key);

  @override
  State<Createprofile> createState() => _CreateprofileState();
}

class _CreateprofileState extends State<Createprofile> {
  TextEditingController name = new TextEditingController();
  TextEditingController hindi = new TextEditingController();
  TextEditingController english = new TextEditingController();
  TextEditingController physics = new TextEditingController();
  TextEditingController chemistry = new TextEditingController();
  TextEditingController math = new TextEditingController();
  TextEditingController fee = new TextEditingController();
  String error = "";
  bool isLoading = false;
  // List<CreateprofileCat> p = [];
  List? data;

  Future<void> Register() async {
    var data = {
      'name': name.text.toString(),
      'hindi': hindi.text.toString(),
      'english': english.text.toString(),
      'physics': physics.text.toString(),
      'chemistry': chemistry.text.toString(),
      'math': math.text.toString(),
      'fee': fee.text.toString(),
    };
    var response = await http.post(
        Uri.parse("https://projmy.000webhostapp.com/demo_api_insert.php"),
        body: json.encode(data));
    var obj = jsonDecode(response.body);
    log(data.toString());
    if (obj['result'] == "S") {
      print("Record is Saved");
    } else {
      print("Record is not Saved");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            const Text(
              "PROFILE DETAILS",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.deepPurple),
            ),
            const Text(
              "Give us few details about yourself",
              style: TextStyle(fontSize: 15),
            ),
            const Text(
              "to create your Profile",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: hindi,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.home,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Hindi',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: english,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.phone_android,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'English',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: physics,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Physics',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: chemistry,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.messenger,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Chemistry',
              ),
            ),
            TextFormField(
              controller: math,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.messenger,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Math',
              ),
            ),
            TextFormField(
              controller: fee,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.messenger,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'fee',
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    minimumSize: const Size(330, 50)),
                child: const Text(
                  'SAVE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                onPressed: () {
                  // Navigator.push(
                  //     context,MaterialPageRoute(builder:(context)=> SelectDeliveryLocation())
                  setState(() {
                    isLoading = true;
                    //PicInsert();
                    Register();
                  });
                }),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
