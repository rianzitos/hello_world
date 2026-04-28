import 'dart:ffi';

import 'package:flutter/material.dart';

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
    return MaterialApp(
      title: "Atividade Responsividade",
      home: Scaffold(
        appBar: AppBar(title: Text("SingleChildScrollView")),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.lock, color: Colors.blue, size: 100)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
