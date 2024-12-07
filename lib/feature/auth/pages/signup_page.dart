import 'package:flutter/material.dart';
import 'package:flutter_task_management/feature/auth/pages/login_page.dart';

class SignUpPage extends StatefulWidget {

  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController  = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    formKey.currentState!.validate();
  }

  void signUpUser(){
    if(formKey.currentState!.validate()){

    }
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
              const Text("Sign Up.", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
              const SizedBox(height: 15,),


              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return "Name field cannot be empty";
                  }
                },
              ),

              const SizedBox(height: 15,),
              TextFormField(
                  controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                validator: (value){
                  if(value == null || value.trim().isEmpty
                      || !value.contains("@")){
                    return "Email field invalid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15,),

              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                    hintText: "Password"
                ),
                validator: (value){
                  if(value == null || value.trim().isEmpty
                      || value.trim().length <= 6){
                    return "Password field invalid";
                  }
                },
              ),
              const SizedBox(height: 15,),

              ElevatedButton(
                  onPressed: (){
                    signUpUser();
                  },
                  child: const Text("Sign Up", style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),),
              ),
              const SizedBox(height: 15,),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, LoginPage.route());
                },
                child: RichText(text: TextSpan(
                  text: 'Already have an account? ',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: const [
                    TextSpan(
                      text: "Sign In",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      )

                    )
                  ]
                )),
              )

            ],
          ),
        ),
      ),
    );
  }
}
