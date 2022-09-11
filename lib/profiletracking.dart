import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class tracking {
  String writtentext = '';
  String writtentext1 = '';

  var first = TextEditingController();

  bool spinner = false;

  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/profile.txt');
  }

  Future<void> writeCounter(String counter) async {
    final file = await _localFile;

    // Write the file
    file.writeAsString(counter);
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return (contents);
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }
}
