import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CameraPage(),
    );
  }
}

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? foto;

  Future<void> tirarFoto() async {
    final picker = ImagePicker();

    final imagem = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (imagem != null) {
      setState(() {
        foto = File(imagem.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Câmera'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (foto != null)
              Image.file(
                foto!,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              )
            else
              const Text('Nenhuma foto tirada'),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: tirarFoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text('TIRAR FOTO'),
            ),
          ],
        ),
      ),
    );
  }
}
