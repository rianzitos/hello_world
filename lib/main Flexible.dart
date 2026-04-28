import 'package:flutter/material.dart';

void main() {
  runApp(ExpandedExample());
}

class ExpandedExample extends StatelessWidget {
  const ExpandedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exemplo Flexible",
      home: Scaffold(
        appBar: AppBar(title: const Text("Flexible")),
        body: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: 120,
                color: Colors.red,
                child: const Center(child: Text("1 parte")),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                height: 120,
                color: Colors.blue,
                child: const Center(child: Text("2 partes")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
