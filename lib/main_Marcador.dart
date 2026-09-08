import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu mapa',
      home: const MapaPage(),
    );
  }
}

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Position? posicao;

  final MapController mapaController = MapController();

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

    Position novaPosicao = await Geolocator.getCurrentPosition();

    setState(() {
      posicao = novaPosicao;
    });

    mapaController.move(
      LatLng(novaPosicao.latitude, novaPosicao.longitude),
      13,
    );
  }

  @override
  void initState() {
    super.initState();
    buscarLocalizacao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Mapa')),

      body: FlutterMap(
        // componente responsável pelo mapa
        mapController: mapaController,

        options: const MapOptions(
          // definições iniciais do mapa
          initialCenter: LatLng(-21.470000, -47.030000),
          initialZoom: 13,
        ),

        children: [
          TileLayer(
            // carrega as imagens que formam o mapa
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.mapa_flutter',
          ),

          if (posicao != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(posicao!.latitude, posicao!.longitude),
                  width: 50,
                  height: 50,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ],
            ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: buscarLocalizacao,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
