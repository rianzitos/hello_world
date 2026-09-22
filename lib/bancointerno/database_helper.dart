// database_helper.dart
// DatabaseHelper é uma classe utilitária criada para centralizar e gerenciar
// todas as operações de conexão, criação, migração e manipulação dobanco de
// dados SQLite
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'tarefa.dart';

class DatabaseHelper {
  // Instância única do banco
  static Database? _database;

  //  Retorna para o banco.
  //  Se ainda não existir, cria.
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  // Criação/abertura do banco
  Future<Database> _initDatabase() async {
    final caminho = join(await getDatabasesPath(), 'tarefa.db');

    return await openDatabase(
      caminho, 
      version: 1,

      //  Executando somente na primeira criação do banco
      onCreate:(db, version) async {
        await db.execute(''' 
          CREATE TABLE tarefas (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao TEXT NOT NULL,
          prioridade TEXT NOT NULL,
          status TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // CREATE
  Future<int> inserirTarefa(Tarefa tarefa) async {
    final db = await database;

    return await db.insert('tarefas', tarefa.toMap());
  }

  // READ
  Future<List<Tarefa>> listarTarefas() async {
    final db = await database;

    final resultado = await db.query('tarefas', orderBy: 'id DESC');

    return resultado.map((map) => Tarefa.fromMap(map)).toList();
  }

  // UPDATE
  Future<int> atualizarTarefa(Tarefa tarefa) async {
    final db = await database;

    return await db.update(
      'tarefas',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
  }

  //DELETE
  Future<int> excluirTarefa(int id) async {
    final db = await database;

    return await db.delete('tarefas', where: 'id = ?', whereArgs: [id]);
  }
}
