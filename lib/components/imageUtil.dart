import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';

class Utility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Image imageFromBase64String2(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
      color: Colors.black,
      colorBlendMode: BlendMode.color,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
