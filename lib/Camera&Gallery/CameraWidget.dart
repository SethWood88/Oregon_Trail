import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CameraWidget extends StatefulWidget {
  final Function(File image) onPictureTaken;

  const CameraWidget({Key key, this.onPictureTaken}) : super(key: key);

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePicture() async {
    final XFile pictureFile = await _picker.pickImage(source: ImageSource.camera);
    if (pictureFile != null) {
      final imageFile = File(pictureFile.path);
      Directory appDocDir = await getExternalStorageDirectory();
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
      File savedImage = await imageFile.copy('${appDocDir.path}/$fileName');
      widget.onPictureTaken(savedImage);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _takePicture(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        return const SizedBox.shrink();
      },
    );
  }
}
