import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/correct/Class1.dart';
import 'package:flutter_application_1/correct/Class2.dart';
import 'package:flutter_application_1/correct/Class3.dart';
import 'package:flutter_application_1/home_page.dart';


import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: Home_page(),
      
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = true;
  File? file;
  var output;
  var label;
  var fine;
  ImagePicker image = ImagePicker();
  var gfg = {
    'Class 1': 'Class 1',
    'Class 2': 'Class 2',
    'Class 3': 'Class 3',
  };

  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });
  }

  detectimage(File l) async {
    var prediction = await Tflite.runModelOnImage(
      path: l.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      output = prediction;
      label = (output![0]['label']).toString().substring(2);
      fine = gfg[label];
      loading = false;
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  getImageFromCamera() async {
    var img = await image.pickImage(source: ImageSource.camera);

    setState(() {
      file = File(img!.path);
    });
    detectimage(file!);
    return detectimage(file!);
  }

  getImageFromGallery() async {
    var img = await image.pickImage(source: ImageSource.gallery);

    setState(() {
      file = File(img!.path);
    });
    detectimage(file!);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'NITROGEN',
        ),
      ),
      body: Container(
        height: h,
        width: w,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              loading == true
                  ? Container()
                  : Container(
                      //color: Color.fromARGB(255, 134, 237, 141),
                      child: Column(
                        children: [
                          Container(
                            height: 380,
                    
                            padding: EdgeInsets.all(15),
                            child: Image.file(file!),
                          ),
                          Text(
                            (output![0]['label']).toString().substring(1),
                          ),
                          Text(
                            'Confidence: ' +
                                (output![0]['confidence']).toStringAsFixed(4),
                          ),
                         
                        ],
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              
              Container(
                child: ClipRect(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: Colors.pink,
                     onPressed: getImageFromGallery,
                    child: Text(
                      "เอาในเครื่อง",
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ),
               SizedBox(
                height: 10,
              ),
              Container(
                child: ClipRect(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: Colors.pink,
                    onPressed: getImageFromCamera,
                    child: Text(
                      "กล้องถ่ายรูป",
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ),
               SizedBox(
                height: 10,
              ),
              Container(
                child: ClipRect(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: Colors.pink,
                    
                    onPressed: () async {
                      
                        if(fine == "Class 1" ){
                     
                      
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Class1(fine: fine)));
                      }else if(fine == "Class 2"){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Class2()));

                      }else if(fine == "Class 3"){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Class3()));

                      }else{
                        uploadimageData();
                        return;
                      }
                      },
                      
                    
                    child: Text(
                      "เเก้ไข",
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<Null> uploadimageData() async{
    String urlUpload = 'http://192.168.82.189/my_app/image.php';
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'image$i.jpg';
    try{
      Map<String,dynamic> map =Map();
      map['file'];

    }catch(e){

    }

  }
}
