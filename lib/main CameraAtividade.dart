import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const StudyFlow());
}

class StudyFlow extends StatelessWidget {
  const StudyFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudyFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 110, 23, 23),
        ),
        useMaterial3: true,
      ),
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
  final TextEditingController controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> tarefas = [
    {
      "titulo": "Estudar Matemática",
      "feita": false,
      "foto": null,
    },
    {
      "titulo": "Resumo de Química",
      "feita": true,
      "foto": null,
    },
    {
      "titulo": "Exercícios de Português",
      "feita": false,
      "foto": null,
    },
  ];

  // Foto selecionada dentro do dialog de "Nova tarefa", antes de confirmar
  File? fotoNovaTarefa;

  Future<void> tirarFotoDialog(StateSetter setDialogState) async {
    final imagem = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (imagem != null) {
      setDialogState(() {
        fotoNovaTarefa = File(imagem.path);
      });
    }
  }

  Future<void> tirarFotoTarefa(int index) async {
    final imagem = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (imagem != null) {
      setState(() {
        tarefas[index]["foto"] = File(imagem.path);
      });
    }
  }

  void adicionarTarefa() {
    fotoNovaTarefa = null;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text("Nova tarefa"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Digite sua tarefa",
                  ),
                ),

                const SizedBox(height: 15),

                if (fotoNovaTarefa != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      fotoNovaTarefa!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),

                if (fotoNovaTarefa != null)
                  const SizedBox(height: 10),

                OutlinedButton.icon(
                  onPressed: () => tirarFotoDialog(setDialogState),
                  icon: const Icon(Icons.camera_alt),
                  label: Text(
                    fotoNovaTarefa == null
                        ? "Adicionar foto"
                        : "Tirar outra foto",
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.clear();
                  fotoNovaTarefa = null;
                  Navigator.pop(context);
                },
                child: const Text("Cancelar"),
              ),
              FilledButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    setState(() {
                      tarefas.add({
                        "titulo": controller.text.trim(),
                        "feita": false,
                        "foto": fotoNovaTarefa,
                      });
                    });

                    controller.clear();
                    fotoNovaTarefa = null;
                    Navigator.pop(context);
                  }
                },
                child: const Text("Adicionar"),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int concluidas =
        tarefas.where((e) => e["feita"] == true).length;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 170, 14, 3),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("StudyFlow"),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 231, 222, 207),
        foregroundColor: Colors.white,
        onPressed: adicionarTarefa,
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Resumo",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceAround,

                      children: [                        Column(
                          children: [
                            const Icon(
                              Icons.assignment,
                              color: Color.fromARGB(255, 78, 1, 1),
                            ),
                            const SizedBox(height: 5),
                            const Text("Total"),
                            Text(
                              "${tarefas.length}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Color.fromARGB(255, 162, 12, 107),
                            ),
                            const SizedBox(height: 5),
                            const Text("Feitas"),
                            Text(
                              "$concluidas",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  final File? foto = tarefas[index]["foto"];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    clipBehavior: Clip.antiAlias,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          leading: Checkbox(
                            activeColor: const Color.fromARGB(255, 253, 182, 220),
                            value: tarefas[index]["feita"],

                            onChanged: (valor) {
                              setState(() {
                                tarefas[index]["feita"] = valor!;
                              });
                            },
                          ),

                          title: Text(
                            tarefas[index]["titulo"],

                            style: TextStyle(
                              decoration:
                                  tarefas[index]["feita"]
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                            ),
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Color.fromARGB(255, 170, 14, 3),
                                ),
                                onPressed: () => tirarFotoTarefa(index),
                              ),

                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),

                                onPressed: () {
                                  setState(() {
                                    tarefas.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        if (foto != null)
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.file(
                              foto,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}