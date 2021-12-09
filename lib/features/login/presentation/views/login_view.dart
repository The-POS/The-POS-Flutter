import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/login/presentation/controller/login_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: _buildForm(context),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 12),
            const TextField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 12),
            _buildLoginElevatedButton(context)
          ],
        ),
      ),
    );
  }

  Widget _buildLoginElevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: controller.login,
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
      ),
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            'Login',
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
