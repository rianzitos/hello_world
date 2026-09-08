import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minha Localização',
      home: const LocalizacaoPage(),
    );
  }
}

class LocalizacaoPage extends StatefulWidget {
  const LocalizacaoPage({super.key});

  @override
  State<LocalizacaoPage> createState() => _LocalizacaoPageState();
}

class _LocalizacaoPageState extends State<LocalizacaoPage> {
  static const double latitudeCasa = -21.29175;
  static const double longitudeCasa = -47.00277;

  double latitude = 0;
  double longitude = 0;
  double? distanciaMetros;

  Future<void> buscarLocalizacao() async {
    bool servicoAtivo = await Geolocator.isLocationServiceEnabled();

    if (!servicoAtivo) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
    }

    if (permissao == LocationPermission.denied ||
        permissao == LocationPermission.deniedForever) {
      return;
    }

    Position posicao = await Geolocator.getCurrentPosition();

    double distancia = Geolocator.distanceBetween(
      posicao.latitude,
      posicao.longitude,
      latitudeCasa,
      longitudeCasa,
    );

    setState(() {
      latitude = posicao.latitude;
      longitude = posicao.longitude;
      distanciaMetros = distancia;
    });

    print('Latitude: $latitude');
    print('Longitude: $longitude');
    print('Distância até em casa: $distanciaMetros metros');
  }

  String get distanciaFormatada {
    if (distanciaMetros == null) return '';
    if (distanciaMetros! < 1000) {
      return '${distanciaMetros!.toStringAsFixed(0)} m';
    }
    return '${(distanciaMetros! / 10).toStringAsFixed(2)} metros';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha Localização')),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              const Icon(Icons.house, size: 80, color: Colors.blue),

              const SizedBox(height: 20),

              const Text(
                'Localização atual',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              Text('Latitude: $latitude', style: const TextStyle(fontSize: 10)),

              const SizedBox(height: 10),

              Text(
                'Longitude: $longitude',
                style: const TextStyle(fontSize: 10),
              ),

              const SizedBox(height: 20),

              Text(
                'Distância até em casa',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                distanciaMetros != null
                    ? distanciaFormatada
                    : 'Clique no botão para calcular',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: buscarLocalizacao,
                child: const Text('Atualizar localização'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}