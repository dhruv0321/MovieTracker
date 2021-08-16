import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yellow_class_assignment/components/imageUtil.dart';

class MovieFormWidget extends StatelessWidget {
  final String? movieName;
  final String? dirName;
  final String? photoName;
  final ValueChanged<String> onChangedMovieName;
  final ValueChanged<String> onChangedDirName;
  final ValueChanged<String> onChangedPhotoName;

  const MovieFormWidget({
    Key? key,
    this.movieName = '',
    this.dirName = '',
    this.photoName = '',
    required this.onChangedMovieName,
    required this.onChangedDirName,
    required this.onChangedPhotoName,
  }) : super(key: key);

  pickImageFromGallery() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((imgFile) {
      final file = File(imgFile!.path);
      String imgString = Utility.base64String(file.readAsBytesSync());
      print('Image refresh');
      onChangedPhotoName(imgString);
    });
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              addImageButton(),
              SizedBox(height: 8),
              buildMovieName(),
              SizedBox(height: 8),
              buildDirName(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget addImageButton() {
    return InkWell(
      onTap: pickImageFromGallery,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 300,
        width: 400,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
            image: Utility.imageFromBase64String(photoName!).image,
          ),
        ),
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.white60,
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMovieName() => TextFormField(
        maxLines: 1,
        textInputAction: TextInputAction.next,
        initialValue: movieName,
        style: TextStyle(
          color: Colors.greenAccent.shade200,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'What movie did you watch ?',
          hintStyle: TextStyle(color: Colors.greenAccent.shade200),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The Movie Name cannot be empty'
            : null,
        onFieldSubmitted: onChangedMovieName,
      );

  Widget buildDirName() => TextFormField(
        maxLines: 1,
        textInputAction: TextInputAction.done,
        initialValue: dirName,
        style: TextStyle(color: Colors.greenAccent.shade100, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Who was it made by ?',
          hintStyle: TextStyle(color: Colors.greenAccent.shade100),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The Director Name cannot be empty'
            : null,
        onFieldSubmitted: onChangedDirName,
      );
}
