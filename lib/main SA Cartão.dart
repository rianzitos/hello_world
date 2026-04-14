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
        appBar: AppBar(title: const Text("Situação de Aprendizagem")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 67, 66, 67),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 350,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Banco SESI/SENAI",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Icon(Icons.contactless, color: Colors.white),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.sim_card, color: Colors.orange, size: 35),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "1910 2009 1801 4117",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Titular", style: TextStyle(color: Colors.grey, fontSize: 13),),
                        Text("Validade", style: TextStyle(color: Colors.grey, fontSize: 13),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rian Rafael", style: TextStyle(color: Colors.white, fontSize: 17)),
                        Text("07/30", style: TextStyle(color: Colors.white, fontSize: 17)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
