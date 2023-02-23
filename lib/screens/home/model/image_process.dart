import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:flutter_native_image/flutter_native_image.dart';

class ImageProcess {
  static Future<File> setImage(File file) async {
    return await FlutterNativeImage.compressImage(file.path,
        percentage: 40, quality: 40);
  }
}
