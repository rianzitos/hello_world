import 'package:flutter/material.dart';

//Run|Debug|Profile
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ContadorTela());
  }
}

class ContadorTela extends StatefulWidget {
  const ContadorTela({super.key});

  @override
  _ContadorTelaState createState() => _ContadorTelaState();
}

class _ContadorTelaState extends State<ContadorTela> {
  int contador = 0;

  void incrementar() {
    setState(() {
      contador++;
    });
  }

  void decrementar() {
    setState(() {
      contador--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo setState")),
      body: Center(
        child: Text("Contador: $contador", style: TextStyle(fontSize: 30)),
      ),

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: incrementar, 
            child: Icon(Icons.add)),
          SizedBox(height: 10),
      
          FloatingActionButton(
            onPressed: decrementar,
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
