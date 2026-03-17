import 'package:flutter/material.dart';

//Run|Debug|Profile
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar:AppBar(title: Text("Exemplo Row")),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home, size: 40),

                SizedBox(width: 20),

                Icon(Icons.favorite, size:40),

                SizedBox(width: 20),

                Icon(Icons.settings, size: 40),
              ],
            ),
          ),
        ),
      );
    }
  }