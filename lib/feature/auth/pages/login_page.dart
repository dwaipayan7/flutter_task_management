import 'package:flutter/material.dart';
import 'package:flutter_task_management/feature/auth/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState!.validate();
  }

  void loginUser() {
    if (formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "LogIn.",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      !value.contains("@")) {
                    return "Email field invalid";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: "Password"),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.trim().length <= 6) {
                    return "Password field invalid";
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  loginUser();
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,SignUpPage.route());
                },
                child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: const [
                      TextSpan(
                          text: "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
