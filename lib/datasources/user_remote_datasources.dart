import 'dart:convert';

import 'package:admin_panel/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserRemoteDatasources {
  String baseUrl = "https://e-commerce-d13dc-default-rtdb.firebaseio.com/";

  Future<List<UserModel>> getUsers() async {
    final url = Uri.parse("$baseUrl/hotel/users.json");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body) as Map<String, dynamic>;

      final List<UserModel> users = decodedData.entries.map((entry) {
        final userJson = entry.value as Map<String, dynamic>;

        return UserModel.fromJson(userJson);
      }).toList();

      return users;
    } else {
      throw Exception("Foydalanuvchilarni olishda xatolik: ${response.statusCode}");
    }
  }
}
