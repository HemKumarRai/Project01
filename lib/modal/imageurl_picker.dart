import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project01_app/screen/add_room_screen.dart';

class ImagePickerFromMobile extends StatefulWidget {
  @override
  _ImagePickerFromMobileState createState() => _ImagePickerFromMobileState();
}

class _ImagePickerFromMobileState extends State<ImagePickerFromMobile> {
  File sampleImage;
  String url;
  final formkey = GlobalKey<FormState>();

  Future<void> _getImageFromGalley() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
    Navigator.of(context).pop();
  }

  Future<void> _getImageFromCamera() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      sampleImage = tempImage;
    });
    Navigator.of(context).pop();
  }

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> uploadStatusImage() async {
    if (validateAndSave()) {
//      final StorageReference postImageRef =
//          FirebaseStorage.instance.ref().child("Post Images");
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child("Post Images");
      var timeKey = DateTime.now();
      final StorageUploadTask uploadTask =
          postImageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddRoomScreen(url)));
    }

//    await saveToDataBase(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: PopupMenuButton(
          child: Icon(Icons.image),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: GestureDetector(
                onTap: () {
                  _getImageFromGalley();
                },
                child: Text(
                  "Gallery",
                ),
              ),
            ),
            PopupMenuItem(
              child: GestureDetector(
                  onTap: () {
                    _getImageFromCamera();
                  },
                  child: Text("Camera")),
            )
          ],
        ),
      ),
      body: Center(
        child: sampleImage == null ? Text("Select an Image") : enableUpload(),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Form(
        key: formkey,
        child: Column(
          children: <Widget>[
            Image.file(
              sampleImage,
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: 15.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              elevation: 10.0,
              child: Text("Confirm?"),
              textColor: Colors.white70,
              color: Colors.pink,
              onPressed: () {
                uploadStatusImage();
              },
            )
          ],
        ),
      ),
    );
  }
}
