import 'package:flutter/material.dart';

//Run|Debug|Profile
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Exemplo Comum"),
        ), //AppBar
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [

            Icon(Icons.star, size: 50),
            
            Text(
              "Flutter Layout",
              style: TextStyle(fontSize: 24),
            ),
              
              ElevatedButton(onPressed: () {}, child: Text("Clique aqui"),
              )
              
            ],
          ),
        ),
      ), 
    );
  }
}