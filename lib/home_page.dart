import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class Home_page extends StatelessWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: Container(
          child: ClipRect(
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              color: Colors.pink,
              onPressed: () async {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text(
                "เริ่มใช้งาน",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
