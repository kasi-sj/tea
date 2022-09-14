import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:date_format/date_format.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Play1 extends StatefulWidget {
  Play1({required this.firstCamera, required this.cameras});

  var firstCamera;
  var cameras;

  @override
  State<Play1> createState() => _Play1State();
}

@override
class _Play1State extends State<Play1> {
  @override
  Widget build(BuildContext context) {
    return TakePictureScreen(camera: widget.firstCamera);
  }
}

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Future<File> savepermanent(String imagepath) async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    final name = basename(imagepath);
    DateTime currentTime = DateTime.now();

    String result1 = formatDate(currentTime, [yyyy, mm, dd, HH, n, s]);
    final image = File('${directory.path}/${result1}.jpg');
    return File(imagepath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final image = await _controller.takePicture();

            if (!mounted) return;

            final some = await savepermanent(image.path);

            if (some == null) return;

            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                print(image.path);
                print(some);
                return DisplayPictureScreen(
                  imagePath: some,
                );
              }),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final File imagePath;

  const DisplayPictureScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    print('ok');
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(imagePath),
    );
  }
}
