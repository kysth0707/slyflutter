import 'dart:convert';

import 'package:http/http.dart' as http;


Future<String> Get(String urlString) async {
  final response = await http.get(Uri.parse(urlString));
  if(response.statusCode == 200){
    String Value = utf8.decode(response.bodyBytes);
    //print(Value);
    return Value;
  }else{
    return "?";
  }
}