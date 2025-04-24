import 'package:admin_panel/datasources/login_datasource.dart';
import 'package:admin_panel/models/login_model.dart';
import 'package:flutter/widgets.dart';

class LoginViewmodel {
  LoginViewmodel._konstruktor();

  static final LoginViewmodel _object = LoginViewmodel._konstruktor();

  final LoginDatasource _datasource = LoginDatasource();

  factory LoginViewmodel() {
    return _object;
  }

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<LoginModel> login() async {
    return await _datasource.fetchLogin();
  }

  Future<bool> validateLogin() async {
    final loginModel = await login();

    if (loginModel.login == loginController.text &&
        loginModel.password == passwordController.text) {
      return true;
    }
    return false;
  }
}
