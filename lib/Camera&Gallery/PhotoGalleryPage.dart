import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oregon_trail/Camera&Gallery/CameraWidget.dart';
import 'package:path_provider/path_provider.dart';

class PhotoGalleryWidget extends StatefulWidget {
  const PhotoGalleryWidget();

  @override
  _PhotoGalleryWidgetState createState() => _PhotoGalleryWidgetState();
}

class _PhotoGalleryWidgetState extends State<PhotoGalleryWidget> {
  List<File> _photoList = [];

  Future<void> _getPhotoList() async {
    Directory appDocDir = await getExternalStorageDirectory();
    setState(() {
      _photoList = appDocDir
          .listSync()
          .where((element) => element.path.endsWith('.jpg'))
          .map((element) => File(element.path))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _getPhotoList();
  }

  Future<void> _deletePhoto(File photo) async {
    await photo.delete();
    _getPhotoList();
  }

  Future<void> _onPictureTaken(File imageFile) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    File savedImage = await imageFile.copy('${appDocDir.path}/$fileName');
    _getPhotoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Divider(color: Colors.black, thickness: 3),
              Center(
                  child: Text('Gallery',
                      style:
                          TextStyle(color: Colors.green[900], fontSize: 28))),
              Divider(color: Colors.black, thickness: 3),
            ],
          ),
          Expanded(
            child: _photoList.isEmpty
                ? Center(child: Text('No Photos'))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                    ),
                    physics: BouncingScrollPhysics(),
                    itemCount: _photoList.length,
                    itemBuilder: (BuildContext context, int index) {
                      File photo = _photoList[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                body: Center(
                                  child: Image.file(photo),
                                ),
                              ),
                            ),
                          );
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Photo?'),
                                content: Text(
                                    'Are you sure you want to delete this photo?'),
                                actions: <Widget>[
                                  RawMaterialButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('Cancel'),
                                  ),
                                  RawMaterialButton(
                                    onPressed: () {
                                      _deletePhoto(photo);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Image.file(photo, fit: BoxFit.cover),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: TakePictureButton(onPictureTaken: _onPictureTaken),
    );
  }
}

class TakePictureButton extends StatefulWidget {
  final Function(File image) onPictureTaken;

  const TakePictureButton({Key key, this.onPictureTaken}) : super(key: key);

  @override
  _TakePictureButtonState createState() => _TakePictureButtonState();
}

class _TakePictureButtonState extends State<TakePictureButton> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePicture() async {
    final XFile pictureFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pictureFile != null) {
      final imageFile = File(pictureFile.path);
      widget.onPictureTaken(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green[900],
      onPressed: () async {
        final imageFile = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CameraWidget(onPictureTaken: (File image) {
                    print('Picture taken: $image');
                    return image;
                  })),
        );
        if (imageFile != null) {
          // Do something with the image file
        }
      },
      tooltip: 'Take a Photo',
      child: Icon(Icons.camera_alt_rounded),
    );
  }
}
