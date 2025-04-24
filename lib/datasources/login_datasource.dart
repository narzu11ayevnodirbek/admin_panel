import 'dart:convert';

import 'package:admin_panel/models/login_model.dart';
import 'package:http/http.dart' as http;

class LoginDatasource {
  static const _baseUrl =
      "https://e-commerce-d13dc-default-rtdb.firebaseio.com";

  Future<LoginModel> fetchLogin() async {
    final url = Uri.parse("$_baseUrl/hotel/admin.json");

    final response = await http.get(url);

    final data = jsonDecode(response.body);
    return LoginModel.fromJson(data);
  }
}
