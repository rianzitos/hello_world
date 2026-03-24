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
        appBar:AppBar(title: Text("Exemplo Container")),
           body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  width: 200,
                  height: 100,
                  color: Colors.blue,
                  child: Center(
                    child: Text("Caixa 1", style: TextStyle(color: Colors.white)),
                  ),
                ),
              
                SizedBox(width: 20,
                height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    color: Colors.red,
                  
                  ),
                  SizedBox(width: 20,
                  height: 20,
                  ),

                   Container(
                    height: 80,
                    width: 80,
                    color: Colors.green,
                    
                  ),
                ],
              )
              ]
              
            )
           ),
      ),
    );
}
}