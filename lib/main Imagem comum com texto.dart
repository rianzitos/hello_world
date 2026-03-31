//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
//import 'package:hello_world/main%20Atividade.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Texto e Imagem")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Bem-vindo ", style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              Image.asset('assets/images/6386374.jpg', width: 200),
            ],
          ),
        ),
      ),
    );
  }
}
