
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_app/screens/bar_item_pages/main_page.dart';

import '../../bar_item_pages/home_screen.dart';
import '../regsiter/register.dart';
import 'login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final cubit = LoginCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            onLogginSuccess();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            title: const Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
            elevation: 0,
          ),
          body: //Container(
          // color: Colors.blue,
          // child:
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(50),
                child: Icon(
                  Icons.person,
                  size: 55,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      // Vertical   => Main
                      // Horizontal => Cross

                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email required";
                            }
                            // Not contain @ OR Not contain .
                            if (!value.contains("@") || !value.contains(".")) {
                              return "Invalid email!";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: passwordController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                obscureText = !obscureText;
                                setState(() {});
                              },
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password required";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => ForgetScreen(),
                              //     ));
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Forget password ?",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => login(),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: const StadiumBorder()),
                                child: const Text("Login"),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => navToRegisterScreen(),
                                style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder()),
                                child: const Text("Register"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    String email = emailController.text;
    String password = passwordController.text;

    cubit.login(email: email, password: password);
  }

  navToRegisterScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        ));
  }

  void onLogginSuccess() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  void displayToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void displaySnackBar(String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
