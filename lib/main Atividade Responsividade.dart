import 'package:flutter/material.dart';

void main() {
  runApp(const SafeAreaExample());
}

class SafeAreaExample extends StatelessWidget {
  const SafeAreaExample({super.key});

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: "Atividade",
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Icon(Icons.lock, size: 100, color: Colors.blue),
                  ),
                  SizedBox(height: 20),
                  Text("Login", style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: largura * 0.8,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: largura * 0.8,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Ação de login
                        },
                        child: Text("Entrar"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(350, 50),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Ação de cadastro
                        },
                        child: Text("Criar conta"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(350, 50),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                        ),
                      ),
                      SizedBox(height: 400),
                      ElevatedButton(
                        onPressed: () {
                          //botão escondido
                        },
                        child: Text(""),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(350, 50),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
