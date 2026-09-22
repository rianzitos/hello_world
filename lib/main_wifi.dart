import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String temperatura = '--';

  Future<void> buscarTemperatura() async {
    try {
      final resposta = await http.get(
        Uri.parse('http://10.140.169.27:5000/temperatura'),
      );

      final dados = jsonDecode(resposta.body);

      setState(() {
        temperatura = dados['temperatura'].toString();
      });
    } catch (e) {
      setState(() {
        temperatura = 'Erro';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IoT com Wi-Fi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Temperatura',
              style: TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 20),

            Text(
              '$temperatura °C',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: buscarTemperatura,
              child: const Text('Buscar temperatura'),
            ),
          ],
        ),
      ),
    );
  }
}
