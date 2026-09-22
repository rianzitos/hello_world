import 'package:flutter/material.dart';

import 'tarefa.dart';
import 'database_helper.dart';

void main() {
  runApp(const MeuAplicativo());
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tarefas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TarefasPage(),
    );
  }
}

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  final TextEditingController descricaoController = TextEditingController();

  String prioridadeSelecionada = 'Média';

  List<Tarefa> tarefas = [];

  @override
  void initState() {
    super.initState();

    carregarTarefas();
  }

  // READ
  Future<void> carregarTarefas() async {
    final resultado = await dbHelper.listarTarefas();

    setState(() {
      tarefas = resultado;
    });
  }

  // CREATE
  Future<void> adicionarTarefa() async {
    final descricao = descricaoController.text.trim();

    if (descricao.isEmpty) {
      return;
    }

    final tarefa = Tarefa(
      descricao: descricao,
      prioridade: prioridadeSelecionada,
      status: 'Pendente',
    );

    await dbHelper.inserirTarefa(tarefa);

    descricaoController.clear();

    setState(() {
      prioridadeSelecionada = 'Média';
    });

    await carregarTarefas();
  }

  // UPDATE
  Future<void> concluirTarefa(Tarefa tarefa) async {
    final tarefaAtualizada = Tarefa(
      id: tarefa.id,
      descricao: tarefa.descricao,
      prioridade: tarefa.prioridade,
      status: 'Concluída',
    );

    await dbHelper.atualizarTarefa(tarefaAtualizada);

    await carregarTarefas();
  }

  // DELETE
  Future<void> excluirTarefa(int id) async {
    await dbHelper.excluirTarefa(id);

    await carregarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Tarefas')),

      body: Column(
        children: [
          // FORMULÁRIO
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: descricaoController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição da tarefa',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: prioridadeSelecionada,
                  decoration: const InputDecoration(
                    labelText: 'Prioridade',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Baixa', child: Text('Baixa')),
                    DropdownMenuItem(value: 'Média', child: Text('Média')),
                    DropdownMenuItem(value: 'Alta', child: Text('Alta')),
                  ],
                  onChanged: (valor) {
                    if (valor != null) {
                      setState(() {
                        prioridadeSelecionada = valor;
                      });
                    }
                  },
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: adicionarTarefa,
                    child: const Text('ADICIONAR TAREFA'),
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          // LISTAGEM
          Expanded(
            child: tarefas.isEmpty
                ? const Center(child: Text('Nenhuma tarefa cadastrada.'))
                : ListView.builder(
                    itemCount: tarefas.length,
                    itemBuilder: (context, index) {
                      final tarefa = tarefas[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),

                        child: ListTile(
                          leading: CircleAvatar(child: Text('${tarefa.id}')),

                          title: Text(
                            tarefa.descricao,
                            style: TextStyle(
                              decoration: tarefa.status == 'Concluída'
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),

                          subtitle: Text(
                            'Prioridade: ${tarefa.prioridade}\n'
                            'Status: ${tarefa.status}',
                          ),

                          isThreeLine: true,

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Concluir
                              if (tarefa.status != 'Concluída')
                                IconButton(
                                  icon: const Icon(Icons.check),
                                  tooltip: 'Concluir',
                                  onPressed: () {
                                    concluirTarefa(tarefa);
                                  },
                                ),

                              // Excluir
                              IconButton(
                                icon: const Icon(Icons.delete),
                                tooltip: 'Excluir',
                                onPressed: () {
                                  excluirTarefa(tarefa.id!);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    descricaoController.dispose();

    super.dispose();
  }
}
