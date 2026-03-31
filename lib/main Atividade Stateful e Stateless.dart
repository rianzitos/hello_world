import 'dart:async';

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
      if (contador > 0) {
        contador--;
      }
    });
  }
  // Image.asset("imagens/android-red-dead-redemption-2-background-2160-x-3840-ph9wie8rbnc35rah.jpg");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/android-red-dead-redemption-2-background-2160-x-3840-ph9wie8rbnc35rah.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Aplicativo de likes e deslikes"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                size: 80,
                color: Color.fromRGBO(255, 0, 0, 1),
              ),
              SizedBox(height: 25),
              Text(
                "$contador Curtidas",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              ElevatedButton(onPressed: incrementar, child: Text("Curtir👍")),
              SizedBox(height: 10),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: decrementar,
                child: Text("Descurtir👎"),
              ),
              ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}