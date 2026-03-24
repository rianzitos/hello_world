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

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(centerTitle:true, title: Text("Aplicativo de curtidas")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, size: 80,
              color: Color.fromRGBO(255, 0, 0, 1),),
              SizedBox(width: 25, height: 25),
              Text(
                "$contador Curtidas",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 25, height: 25),
              ElevatedButton(
                onPressed: () {
                  incrementar();
                },
                child: Text("Curtir"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
