import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CameraDescription>? cameras;
  CameraController? controller;
  late String imagePath;

  @override
  void initState() {
    initializeCamera();
    super.initState();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    try {
      if (cameras!.isEmpty) {
        // Handle scenario when no cameras are available
        return;
      }
      controller = CameraController(cameras![0], ResolutionPreset.max);
      await controller!.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to initialize camera: $e');
      }
      // Handle camera initialization error
    }
  }

  void captureImage() async {
    try {
      await controller!.takePicture().then((XFile file) {
        setState(() {
          imagePath = file.path;
        });
        if (kDebugMode) {
          print('Image Path: $imagePath');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error capturing image: $e');
      }
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(color: Colors.black87, child: const SizedBox(height: 60)),
          Expanded(
            flex: 11,
            child: FutureBuilder<void>(
              future: controller!.initialize(), // Use FutureBuilder for initialization
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(controller!);
                } else {
                  return Container();
                }
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.black87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    shape: const CircleBorder(),
                    color: Colors.black54,
                    child: InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.list_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    shape: const CircleBorder(),
                    color: Colors.black54,
                    child: InkWell(
                      onTap: captureImage,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 65,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    shape: const CircleBorder(),
                    color: Colors.black54,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/menu');
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}