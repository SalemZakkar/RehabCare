import 'dart:io';
import 'dart:typed_data';

class Attachment {
  File file;
  String name;

  Attachment({required this.file, required this.name});

  String get type => file.path.split(".").last;

  Uint8List get bytes => file.readAsBytesSync();
}

List<Attachment> attachments = [];
