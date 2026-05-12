import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TelaController());
  }
}

class TelaController extends StatefulWidget {
  const TelaController({super.key});

  @override
  _TelaControllerState createState() => _TelaControllerState();
}

class _TelaControllerState extends State<TelaController> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo TextEditingController")),
      body: Column(
        children: [
          TextField(controller: controller),

          ElevatedButton(
            onPressed: () {
              print(controller.text);
            },
            child: Text("Mostrar"),
          ),
        ],
      ),
    );
  }
}
