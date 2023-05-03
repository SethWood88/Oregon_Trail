import 'dart:io';

import 'package:flutter/material.dart';

class FullScreenImagePage extends StatelessWidget {
  final File imageFile;

  const FullScreenImagePage({Key key, this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Screen Image'),
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: Image.file(
          imageFile,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
