import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
abstract class IHttpClient{
  Future get( {required String url});
}

class HttpClient implements IHttpClient {
  final client = http.Client();


  @override
  Future get({required String url}) async {
    return await client.get(Uri.parse(url));
  }

}