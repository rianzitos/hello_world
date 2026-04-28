import 'package:flutter/material.dart';

void main() {
  runApp(MediaQueryExample());
}

class MediaQueryExample extends StatelessWidget {
  const MediaQueryExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "MediaQuery", home: const HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("MediaQuery")),
      body: Center(
        child: Container(
          width: largura * 0.8,
          height: 120,
          color: Colors.green,
          child: const Center(
            child: Text(
              "Container Responsivo",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
