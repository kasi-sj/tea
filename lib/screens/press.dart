import 'dart:async';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:vee/core.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Press1 extends StatefulWidget {
  Press1({required this.firstCamera, required this.cameras});

  var firstCamera;
  var cameras;

  @override
  State<Press1> createState() => _Press1State();
}

@override
class _Press1State extends State<Press1> {
  @override
  Widget build(BuildContext context) {
    return TakePictureScreen(camera: widget.firstCamera);
  }
}

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  var pre = null;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  getof(String st) async {
    final _repository = PlatformCore();
    String text = await _repository.changeColor(st);
    print(st);
    return st;
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
            await DefaultCacheManager().emptyCache();
            await _initializeControllerFuture;

            final image = await _controller.takePicture();

            if (!mounted) return;

            final exp = await getof(image.path);

            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                print(image.path);

                return DisplayPictureScreen(
                  imagePath: exp,
                );
              }),
            );
          } catch (e) {
            print('some');
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    print('ok');
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Text(imagePath),
    );
  }
}
