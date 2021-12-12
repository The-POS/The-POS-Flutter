import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/login/presentation/controller/login_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final LoginController controller = Get.find<LoginController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

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
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameTextEditingController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(labelText: 'Username'),
              validator: controller.validateInput,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: passwordTextEditingController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: controller.validateInput,
            ),
            const SizedBox(height: 12),
            _buildLoginElevatedButton(context)
          ],
        ),
      ),
    );
  }

  Widget _buildLoginElevatedButton(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? const CircularProgressIndicator()
          : _buildElevatedButton(context),
    );
  }

  ElevatedButton _buildElevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          controller.login(
            usernameTextEditingController.text,
            passwordTextEditingController.text,
          );
        }
      },
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
