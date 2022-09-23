import 'package:flutter/material.dart';
import 'package:customers/models/user_model.dart';
import 'package:customers/helpers/messages.dart';

class UserRequest {
  Messages message = Messages();
  loginRequest(UserModel userModel, context) {
    if (userModel.email.isEmpty) {
      message.errorMessage("El campo usuario es obligatorio", context);
      return false;
    }

    if (userModel.password.isEmpty) {
      message.errorMessage("El campo password es obligatorio", context);
      return false;
    }

    return true;
  }
}
