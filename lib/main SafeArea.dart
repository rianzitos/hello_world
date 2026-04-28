import 'package:flutter/material.dart';

void main() {
  runApp(const SafeAreaExample());
}

class SafeAreaExample extends StatelessWidget {
  const SafeAreaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Safe Area Example",
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              Text("Aplicação Flutter", style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              Text("Conteúdo protegido por SafeArea"),
            ],
          ),
        ),
      ),
    );
  }
}
