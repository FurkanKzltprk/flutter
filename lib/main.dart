import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Furkan Kamera uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
          color: Colors.red, // AppBar arka plan rengi
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.red, // FloatingActionButton arka plan rengi
          foregroundColor: Colors.white, // FloatingActionButton ikon rengi
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getExternalStorageDirectory(); // path_provider kullanarak galeri dizinini alın
      final name = DateTime.now().toIso8601String();
      final file = File('${directory!.path}/$name.png'); // .path ile dosya yolunu alın
      await pickedFile.saveTo(file.path);
      setState(() {
        _image = file;
      });
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final directory = await getExternalStorageDirectory(); // path_provider kullanarak galeri dizinini alın
      final name = DateTime.now().toIso8601String();
      final file = File('${directory!.path}/$name.png'); // .path ile dosya yolunu alın
      await pickedFile.saveTo(file.path);
      setState(() {
        _image = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Furkan Kamera uygulaması',
          style: TextStyle(color: Colors.white), // AppBar metin rengi
        ),
      ),
      body: Center(
        child: _image == null
            ? Text('Fotoğraf çek veya seç')
            : Image.file(_image!),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _takePhoto,
            tooltip: 'Fotoğraf çek',
            child: Icon(Icons.camera),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _pickImageFromGallery,
            tooltip: 'Galeriden fotoğraf seç',
            child: Icon(Icons.photo),
          ),
        ],
      ),
    );
  }
}
