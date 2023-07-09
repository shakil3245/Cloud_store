
import 'package:file_picker/file_picker.dart';
import 'package:firebasepractice/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final firebase_storaage _storage = firebase_storaage();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(child: Text("Firebase",style: TextStyle(color: Colors.white),)),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent
                ),
                onPressed: () async{
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'png', 'doc'],
                  );
                  if (result != null) {
                     final path = result.files.single.path!;
                     final fileName = result.files.first.name;
                     _storage.uploadFile(path, fileName).then((value) =>
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Image Uploaded!") )),
                     );
                    print(path);
                    print(fileName);


                  } else {
                    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("No file selected")));
                    return null;
                  }

                }, child: Text("Upload File")),
          ),
        ],
      ),
    );
  }
}
