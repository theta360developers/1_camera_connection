import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'THETA X',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 45,
                  fontFamily: 'Questrial',
                  color: Colors.green,
                ),
              ),
            ),
            const Text(
              'BUTTON CONTROLS',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27, fontFamily: 'Questrial'),
            ),
            const SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      print('press info!');
                      var url = Uri.parse('http://192.168.1.1/osc/info');
                      var header = {
                        'Content-Type': 'application/json;charset=utf-8'
                      };
                      var response = await http.get(url, headers: header);
                      print(response.body);
                    },
                    child: Text('Info'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shadowColor: Colors.grey,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      print("press state!");
                      var url = Uri.parse('http://192.168.1.1/osc/state');
                      var header = {
                        'Content-Type': 'application/json;charset=utf-8'
                      };
                      var response = await http.post(url, headers: header);
                      print(response.body);
                      //getting battery Level
                      var thetaState = jsonDecode(response.body);
                      var batteryLevel = thetaState['state']['batteryLevel'];
                      print(batteryLevel);
                      if (batteryLevel < 0.5) {
                        print('Charging Required');
                      }
                    },
                    child: const Text('State'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shadowColor: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    print("press state!");
                    var url =
                        Uri.parse('http://192.168.1.1/osc/commands/execute');
                    var header = {
                      'Content-Type': 'application/json;charset=utf-8'
                    };
                    var bodyMap = {'name': 'camera.takePicture'};
                    var bodyJson = jsonEncode(bodyMap);
                    var response =
                        await http.post(url, headers: header, body: bodyJson);
                    print(response.body);
                    //  print(response.body[0]);
                  },
                  child: Icon(Icons.camera),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black38,
                      shadowColor: Colors.grey,
                      fixedSize: Size(60, 60),
                      shape: CircleBorder()),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
