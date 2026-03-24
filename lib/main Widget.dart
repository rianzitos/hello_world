import 'package:flutter/material.dart';

//Run|Debug|Profile
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Minha Tela")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.thumb_up, size: 60),
              SizedBox(width: 40, height: 40),
              Text(
                "D.S. é o melhor curso de SESI?",
                style: TextStyle(
                  fontSize: 22,
                  color: const Color.fromARGB(255, 118, 7, 162),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 40, height: 40),
              ElevatedButton(
                onPressed: () {
                  print("Usuário clicou");
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
