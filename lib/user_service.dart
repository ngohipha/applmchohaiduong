import 'dart:convert';
import 'package:appcv/user_model.dart';
import 'package:http/http.dart' as http;

Future<List<User>> fetchUsers(int page) async {
  final response = await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final data = json['data'] as List<dynamic>;
    return data.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}