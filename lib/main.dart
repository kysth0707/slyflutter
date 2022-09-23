import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(scaffoldBackgroundColor: Colors.black87),
      //Container(width: 50, height: 50, color : Colors.black87)
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text('SLY   -   Save Listen Youtube',
              style: TextStyle(fontSize: 20))
        ),
        body: Container(
          child: Text('ㅎㅇ',
            style: TextStyle(color:Colors.white))
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.music_note),
              Icon(Icons.mail),
              Icon(Icons.contact_page)
            ],
          ),
        ),
      )
    );
  }
}
