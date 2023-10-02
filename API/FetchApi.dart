import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchApi {
  String url = "https://64dc92dbe64a8525a0f6b61e.mockapi.io/employee";

  Future<List> getData() async {
    http.Response data = await http.get(Uri.parse(url));
    return jsonDecode(data.body.toString());
  }

  Future<void> deleteData(int id) async {
    await http.delete(Uri.parse("$url/$id"));
  }

  Future<void> insertData(Map<String, dynamic> map) async {
    await http.post(Uri.parse(url), body: map);
  }

  Future<void> updateData(Map<String, dynamic> map, int id) async {
    await http.put(Uri.parse("$url/$id"), body: map);
  }
}
