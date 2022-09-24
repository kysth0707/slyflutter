import 'package:flutter/material.dart';

var WebPage = 0;

void main() {
  // runApp(const MyApp());
  runApp(MaterialApp(home: MyApp(),));
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
              IconButton(onPressed: () {
                WebPage = 0;
                Navigator.push(context, MaterialPageRoute(builder: (context) => MusicSearch()),);
              }, icon: Icon(Icons.music_note)),
              IconButton(onPressed: () {
                WebPage = 1;
                Navigator.push(context, MaterialPageRoute(builder: (context) => MusicList()),);
              }, icon: Icon(Icons.dynamic_feed)),
              IconButton(onPressed: () {
                WebPage = 2;
              }, icon: Icon(Icons.dvr_rounded)),
            ],
          ),
        ),
      )
    );
  }
}

class MusicSearch extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black87),
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black45,
            title: Text('SLY   -   Save Listen Youtube',
                style: TextStyle(fontSize: 20))
        ),
        body: Row(
          children: <Widget>[
            SizedBox(width: 20),
            Expanded(child:
            TextField(decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white)),
            ), style: TextStyle(color: Colors.white)
            ),
            ),
            SizedBox(width: 20),
            ElevatedButton.icon( onPressed: () { }, icon: Icon(Icons.search, size: 18), label: Text("Search"), ),
            SizedBox(width: 20),
          ],
        ),

        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () {
                WebPage = 0;
              }, icon: Icon(Icons.music_note)),
              IconButton(onPressed: () {
                WebPage = 1;
                Navigator.push(context, MaterialPageRoute(builder: (context) => MusicList()),);
              }, icon: Icon(Icons.dynamic_feed)),
              IconButton(onPressed: () {
                WebPage = 2;
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()),);
              }, icon: Icon(Icons.dvr_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}


class MusicList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black87),
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black45,
            title: Text('SLY   -   Save Listen Youtube',
                style: TextStyle(fontSize: 20))
        ),
        body: ListView.builder(itemCount: 10,
          padding: EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index){
            return Row(
              children: [
                Icon(Icons.music_video, color: Colors.white,),
                Container(
                  height: 50,
                  child: Center(
                    child: Text('ㅎㅇ ${index}',
                      style: TextStyle(color: Colors.white),),
                  )
                )
              ],
            );
          }),



        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () {
                WebPage = 0;
                Navigator.push(context, MaterialPageRoute(builder: (context) => MusicSearch()),);
              }, icon: Icon(Icons.music_note)),
              IconButton(onPressed: () {
                WebPage = 1;
              }, icon: Icon(Icons.dynamic_feed)),
              IconButton(onPressed: () {
                WebPage = 2;
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()),);
              }, icon: Icon(Icons.dvr_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}