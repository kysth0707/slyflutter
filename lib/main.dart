import 'dart:convert';

import 'package:flutter/material.dart';


import 'APIKey.dart' as KEY;
import 'Request.dart' as Request;

var WebPage = 0;
String MusicSearchText = '';
var MusicSearchCount = 0;
List<dynamic> items = jsonDecode('[]');


void main() {
  // runApp(const MyApp());
  runApp(MaterialApp(home: MyApp(),));
}



class Example extends StatefulWidget {
  Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState(); // State 생성.
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text('SLY   -   Save Listen Youtube',
              style: TextStyle(fontSize: 20))
      ),
      body: Column(
        children: [
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Expanded(child:
              TextField(
                decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.white)),),
                style: TextStyle(color: Colors.white),
                onChanged: (text){
                  try{
                    setState(() {
                      MusicSearchText = text;
                    });
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
                    content: Text('검색할 키워드를 입력해주세요!', style: TextStyle(color:Colors.white),),
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
                  // print('val: $val');
                  items = jsonDecode(val)['items'];


                  // print(items.length);

                  setState(() {
                    MusicSearchCount = 5;
                  });

                }).catchError((error) {
                  print('error: $error');
                });
              }, icon: Icon(Icons.search, size: 18), label: Text("Search"), ),
              SizedBox(width: 20),
            ],
          ),

          SizedBox(height: 20,),
          Container(height: 1, color: Colors.white12,),
          SizedBox(height: 30,),
          Text('검색어 : $MusicSearchText', style: TextStyle(color: Colors.white),),
          SizedBox(height: 30,),
          Container(height: 1, color: Colors.white12,),
          SizedBox(height: 20,),

          Expanded(
            child: ListView.builder(itemCount: MusicSearchCount,
                padding: EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int index){
                  return MusicSearchList(index);
                }),
          ),
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
    );
  }

  Widget MusicSearchList(int index) {
    var Title = (items[index]['snippet']['title']);
    var ChannelName = (items[index]['snippet']['channelTitle']);
    var PublishTime = (items[index]['snippet']['publishTime']);
    var ThumbnailURL = (items[index]['snippet']['thumbnails']['default']['url']);
    return Column(
      children: [
        ListTile(
          title: Text(Title, style: TextStyle(color: Colors.white),),
          subtitle: Text('${ChannelName}             ${PublishTime}', style: TextStyle(color: Colors.white),),
          // leading: Icon(Icons.music_video, color: Colors.white,),
          leading: Image.network(ThumbnailURL, width: 120),

          onTap: (){
            print(ThumbnailURL);
          },
        ),
        Container(height: 1, color: Colors.white12,)
      ],
    );
  }
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
      home: Example(),
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