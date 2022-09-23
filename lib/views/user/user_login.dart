import 'package:flutter/material.dart';
import 'package:customers/helpers/text_input.dart';
import 'package:customers/helpers/primary_button.dart';
import 'package:customers/models/user_model.dart';
import 'package:customers/controllers/user_controller.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UserLogin();
  }
}

class _UserLogin extends State<UserLogin> {
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController();
    email.text = "brandon@mail.com";
    password.text = "Brandon2356";
    final userModel = UserModel(name.text, email.text, password.text);
    final userController = UserController();

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        child: Center(
          child: ListView(
            children: [
              //LOGO
              Container(
                width: 120.0,
                height: 120.0,
                margin: const EdgeInsets.only(top: 100.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/customer_logo_katze.png'),
                  ),
                ),
              ),
              //Input Email
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                child: TextInput(
                    "Email", TextInputType.emailAddress, email, 1, false),
              ),
              //Input Password
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                child: TextInput(
                    "Password", TextInputType.text, password, 1, true),
              ),
              //Login button
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                child: PrimaryButton(
                  "Login",
                  () => userController.login(userModel, context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
