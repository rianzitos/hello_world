import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TelaComparacao());
  }
}

class TelaComparacao extends StatefulWidget {
  const TelaComparacao({super.key});

  @override
  _TelaComparacaoState createState() => _TelaComparacaoState();
}

class _TelaComparacaoState extends State<TelaComparacao> {
  final controllerSimples = TextEditingController();
  final controllerForm = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TextField vs TextFormField")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // -----------------------------
            // 🔹TEXT FIELD (SEM VALIDAÇÃO)
            // -----------------------------
            Text("TextField (simples)"),

            TextField(
              controller: controllerSimples,
              decoration: InputDecoration(
                labelText: "Digite algo",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                print("TextField: ${controllerSimples.text}");
              },
              child: Text("Mostrar TextField"),
            ),
            SizedBox(height: 30),

            // -----------------------------
            // 🔹TEXT FIELD (SEM VALIDAÇÃO)
            // -----------------------------
            Text("TextFormField (com validação)"),

            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controllerForm,
                    decoration: InputDecoration(
                      labelText: "Digite seu nome",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        print("TextFormField: ${controllerForm.text}");
                      }
                    },
                    child: Text("Validar Formulário"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
