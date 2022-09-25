import 'dart:convert';

import 'package:flutter/material.dart';


import 'APIKey.dart' as KEY;
import 'Request.dart' as Request;
import 'TestRequestValue.dart' as Test;

var WebPage = 0;
String MusicSearchText = '';

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
        body: Column(
          children: [
            Container(
                child: Text('ㅎㅇ',
                  style: TextStyle(color:Colors.white))
            ),
          ],
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
              TextField(
                  decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.white)),),
                  style: TextStyle(color: Colors.white),
                onChanged: (text){
                    try{
                      MusicSearchText = text;
                    }catch(e){
                      //print(e);
                    }
                },
              ),
            ),
            SizedBox(width: 20),
            ElevatedButton.icon( onPressed: () {
              if(MusicSearchText == ""){
                showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                  backgroundColor: Colors.white10,
                  title: Text('검색 실패', style: TextStyle(color:Colors.white),),
                  content: Text('검색할 키워드르 입력해주세요!', style: TextStyle(color:Colors.white),),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
                return;
              }

              final String Value = MusicSearchText;
              const String Limit = "5";
              final Future<String> future = Request.Get('https://www.googleapis.com/youtube/v3/search?key='+KEY.APIKey+'&part=snippet&order=relevance&q='+Value+'&maxResults='+Limit+'&type=video');
              future.then((val) {
                //val = jsonDecode(val);
                //val = val[0];
                val = jsonDecode( Test.val.toString() );
                //val = val['items'];
                print('val: $val');
              }).catchError((error) {
                print('error: $error');
              });
            }, icon: Icon(Icons.search, size: 18), label: Text("Search"), ),
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
        body: ListView.builder(itemCount: 20,
          padding: EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index){
            return MusicListShow(index);
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

  Widget MusicListShow(int index) {
    return Column(
      children: [
        ListTile(
          title: Text('ㅎㅇ', style: TextStyle(color: Colors.white),),
          subtitle: Text('ㅎㅇ ${index}', style: TextStyle(color: Colors.white),),
          leading: Icon(Icons.music_video, color: Colors.white,),

          onTap: (){
            print(index);
          },
        ),
        Container(height: 1, color: Colors.white12,)
      ],
    );
  }
}

//   Row MusicListShow(int index) {
//     return Row(
//       children: [
//         Icon(Icons.music_video, color: Colors.white),
//         Container(
//           height: 80,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(width: 50,),
//               Column(
//                 children: [
//                   Text('ㅎㅇ ${index}',
//                     style: TextStyle(color: Colors.white, fontSize: 20),),
//                   Text('ㅎㅇ ${index}',
//                     style: TextStyle(color: Colors.white, fontSize: 15),),
//                 ],
//               )
//             ],
//           )
//         )
//       ],
//     );
//   }
// }