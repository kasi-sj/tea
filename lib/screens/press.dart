import 'dart:async';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:vee/core.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

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
    required this.camera,
  });

  final CameraDescription camera;
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  late File _imagefile;
  late List<Face> _faces;

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
    final image = FirebaseVisionImage.fromFile(File(st));
    final facedetector =
        FirebaseVision.instance.faceDetector(FaceDetectorOptions(
      mode: FaceDetectorMode.accurate,
    ));
    List<Face> faces = await facedetector.processImage(image);
    print('hi');
    final bb = faces.first;
    final box = bb.boundingBox;
    print(box.bottom);
    final cor = bb.boundingBox;
    print('dd');
    ;
    print('ff');
    File croppedFile = await FlutterNativeImage.cropImage(
        st,
        cor.left.toInt(),
        cor.top.toInt(),
        (cor.right - cor.left).toInt(),
        (cor.bottom - cor.top).toInt());
    File compressedFile = await FlutterNativeImage.compressImage(
        croppedFile.path,
        quality: 80,
        targetWidth: 48,
        targetHeight: 48);
    compressedFile == null ? print('null') : print('ok bro');
    if (mounted) {
      setState(() {
        _imagefile = compressedFile;
      });
    }
    String text = await _repository.changeColor(st);
    print(text);
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
            File fil = _imagefile;

            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                print(image.path);

                return DisplayPictureScreen(imagePath: fil);
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
  final File imagePath;

  const DisplayPictureScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    print('ok');
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: ListView(
        children: [
          Image.file(imagePath),
        ],
      ),
    );
  }
}
