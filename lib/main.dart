import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ---------------------------------------------------------------------------
// CONFIGURAÇÃO
// Emulador Android  -> http://10.0.2.2/pdm_api
// Celular físico    -> http://IP_DO_SEU_PC/pdm_api  (mesma rede Wi-Fi)
// Flutter Web/Windows -> http://localhost/pdm_api
// ---------------------------------------------------------------------------
const String baseUrl = 'http://10.140.170.18/pdm_api';

void main() => runApp(const MyApp());

// ------------------------------- MODELO ------------------------------------
class Produto {
  final int? id;
  final String nome;
  final double preco;
  final int estoque;

  Produto({
    this.id,
    required this.nome,
    required this.preco,
    required this.estoque,
  });

  factory Produto.fromJson(Map<String, dynamic> j) => Produto(
        id: int.parse(j['id'].toString()),
        nome: j['nome'].toString(),
        preco: double.parse(j['preco'].toString()),
        estoque: int.parse(j['estoque'].toString()),
      );

  Map<String, dynamic> toJson() =>
      {'nome': nome, 'preco': preco, 'estoque': estoque};
}

// ------------------------------- API ---------------------------------------
class Api {
  // Guarda a última requisição para mostrar na tela (bom para a demonstração)
  static final ValueNotifier<String> log =
      ValueNotifier<String>('Nenhuma requisição ainda');

  static const _headers = {'Content-Type': 'application/json'};
  static const _timeout = Duration(seconds: 10);

  static void _registrar(String metodo, String url, http.Response r) {
    log.value = '$metodo $url  →  ${r.statusCode}';
  }

  // GET /produtos
  static Future<List<Produto>> listar() async {
    final url = '$baseUrl/produtos.php';
    final r = await http.get(Uri.parse(url)).timeout(_timeout);
    _registrar('GET', '/produtos', r);
    if (r.statusCode != 200) throw Exception('Erro ${r.statusCode}');
    final lista = jsonDecode(r.body) as List;
    return lista.map((e) => Produto.fromJson(e)).toList();
  }

  // POST /produtos
  static Future<void> criar(Produto p) async {
    final r = await http
        .post(Uri.parse('$baseUrl/produtos.php'),
            headers: _headers, body: jsonEncode(p.toJson()))
        .timeout(_timeout);
    _registrar('POST', '/produtos', r);
    if (r.statusCode != 201) throw Exception(_erro(r));
  }

  // PUT /produtos/{id}
  static Future<void> atualizar(Produto p) async {
    final r = await http
        .put(Uri.parse('$baseUrl/produtos.php?id=${p.id}'),
            headers: _headers, body: jsonEncode(p.toJson()))
        .timeout(_timeout);
    _registrar('PUT', '/produtos/${p.id}', r);
    if (r.statusCode != 200) throw Exception(_erro(r));
  }

  // DELETE /produtos/{id}
  static Future<void> excluir(int id) async {
    final r = await http
        .delete(Uri.parse('$baseUrl/produtos.php?id=$id'))
        .timeout(_timeout);
    _registrar('DELETE', '/produtos/$id', r);
    if (r.statusCode != 200) throw Exception(_erro(r));
  }

  static String _erro(http.Response r) {
    try {
      return jsonDecode(r.body)['erro'].toString();
    } catch (_) {
      return 'Erro ${r.statusCode}';
    }
  }
}

// ------------------------------- APP ---------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDM - REST + HTTP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const ProdutosPage(),
    );
  }
}

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  List<Produto> _produtos = [];
  bool _carregando = true;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() {
      _carregando = true;
      _erro = null;
    });
    try {
      final lista = await Api.listar();
      if (!mounted) return;
      setState(() => _produtos = lista);
    } catch (e) {
      if (!mounted) return;
      setState(() => _erro =
          'Não foi possível conectar à API.\nVerifique se o Apache/MySQL estão ligados e a baseUrl.\n\n$e');
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  void _mensagem(String texto) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(texto)));
  }

  String _moeda(double v) => 'R\$ ${v.toStringAsFixed(2).replaceAll('.', ',')}';

  Future<void> _abrirForm({Produto? produto}) async {
    final nome = TextEditingController(text: produto?.nome ?? '');
    final preco = TextEditingController(
        text: produto != null ? produto.preco.toStringAsFixed(2) : '');
    final estoque =
        TextEditingController(text: produto?.estoque.toString() ?? '');

    final salvar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(produto == null ? 'Novo produto (POST)' : 'Editar (PUT)'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nome,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: preco,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Preço'),
              ),
              TextField(
                controller: estoque,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Estoque'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Salvar')),
        ],
      ),
    );

    if (salvar != true) return;

    final p = Produto(
      id: produto?.id,
      nome: nome.text.trim(),
      preco: double.tryParse(preco.text.replaceAll(',', '.')) ?? -1,
      estoque: int.tryParse(estoque.text) ?? -1,
    );

    try {
      produto == null ? await Api.criar(p) : await Api.atualizar(p);
      _mensagem(produto == null ? 'Produto criado' : 'Produto atualizado');
      await _carregar();
    } catch (e) {
      _mensagem(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> _excluir(Produto p) async {
    final indice = _produtos.indexOf(p);
    setState(() => _produtos.remove(p));
    try {
      await Api.excluir(p.id!);
      _mensagem('Produto removido');
    } catch (e) {
      if (!mounted) return;
      setState(() => _produtos.insert(indice, p));
      _mensagem(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          IconButton(
            tooltip: 'Recarregar (GET)',
            icon: const Icon(Icons.refresh),
            onPressed: _carregar,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirForm(),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Painel com a última requisição HTTP feita
          ValueListenableBuilder<String>(
            valueListenable: Api.log,
            builder: (_, texto, __) => Container(
              width: double.infinity,
              color: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                texto,
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontFamily: 'monospace',
                  fontSize: 13,
                ),
              ),
            ),
          ),
          Expanded(child: _corpo()),
        ],
      ),
    );
  }

  Widget _corpo() {
    if (_carregando) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_erro != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_erro!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                  onPressed: _carregar, child: const Text('Tentar novamente')),
            ],
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _carregar,
      child: _produtos.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 120),
                Center(child: Text('Nenhum produto cadastrado')),
              ],
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _produtos.length,
              itemBuilder: (_, i) {
                final p = _produtos[i];
                return Dismissible(
                  key: ValueKey(p.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _excluir(p),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${p.id}')),
                    title: Text(p.nome),
                    subtitle: Text('${_moeda(p.preco)}  •  Estoque: ${p.estoque}'),
                    trailing: const Icon(Icons.edit, size: 18),
                    onTap: () => _abrirForm(produto: p),
                  ),
                );
              },
            ),
    );
  }
}