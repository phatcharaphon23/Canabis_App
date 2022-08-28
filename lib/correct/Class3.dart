import 'package:flutter/material.dart';

class Class3 extends StatefulWidget {
  const Class3({ Key? key }) : super(key: key);

  @override
  State<Class3> createState() => _Class3State();
}

class _Class3State extends State<Class3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 44, 243, 33),
        title: Text(
          'Class3',
        ),
      ),
      
    );
  }
}