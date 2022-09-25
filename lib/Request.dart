import 'dart:convert';

import 'package:http/http.dart' as http;


Get(String urlString) async {
  final response = await http.get(Uri.parse(urlString));
  if(response.statusCode == 200){
    print("YES");
    print(response.bodyBytes);
    return 'SUCCESS';
  }else{
    return 'FAIL';
  }
}