import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const BluetoothPage());
  }
}

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  List<ScanResult> devices = [];
  String status = 'Toque em Buscar';

  Future<void> buscar() async {
    // Verifica se o Bluetooth está ligado
    if (FlutterBluePlus.adapterStateNow != BluetoothAdapterState.on) {
      setState(() {
        status = 'Ligando Bluetooth...';
      });

      try {
        await FlutterBluePlus.turnOn();
      } catch (e) {
        setState(() {
          status = 'Não foi possível ligar o Bluetooth';
        });

        print('Erro ao ligar Bluetooth: $e');
        return;
      }
    }
    setState(() {
      devices = [];
      status = 'Buscando...';
    });

    // Recebe os dispositivos encontrados
    FlutterBluePlus.scanResults.listen((resultados) {
      setState(() {
        devices = resultados;
      });
    });

    // Procura por 5 segundos
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    setState(() {
      status = 'Busca finalizada';
    });
  }

  Future<void> conectar(BluetoothDevice device) async {
    setState(() {
      status = 'Conectando...';
    });

    try {
      await device.connect(license: License.nonprofit);

      setState(() {
        status = 'Conectado!';
      });

      print('Conectado em: ${device.remoteId}');
    } catch (e) {
      setState(() {
        status = 'Erro: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teste Bluetooth')),

      body: Column(
        children: [
          const SizedBox(height: 20),

          Text(status),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: buscar,
            child: const Text('Buscar dispositivos'),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final resultado = devices[index];

                final nome = resultado.advertisementData.advName.isNotEmpty
                    ? resultado.advertisementData.advName
                    : 'Sem nome';

                return ListTile(
                  leading: const Icon(Icons.bluetooth),
                  title: Text(nome),
                  subtitle: Text(resultado.device.remoteId.toString()),
                  onTap: () {
                    conectar(resultado.device);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
