import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Demonstração de Áudio'),
        ),
        body: Center(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.play_arrow),
            label: const Text('Reproduzir'),
            onPressed: () async {
              final player = AudioPlayer();

              await player.play(
                AssetSource('audio/som.mp3'),
              );
            },
          ),
        ),
      ),
    );
  }
}
