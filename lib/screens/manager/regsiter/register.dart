import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  final cubit = RegisterCubit();


  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
        create: (context) => cubit,
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            onStateChange(state);
          },
          //TODO
          // child: GestureDetector(
          // onTap: () {
          // FocusScope.of(context).requestFocus(FocusNode());
          // },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Register"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: phoneController,
                    textInputAction: TextInputAction.next,
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        String email = emailController.text;
                        String password = passwordController.text;
                        cubit.createAccount(email, password);
                        print('Register pressed');
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                      child: const Text("Register"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //),
        ),
      );
  }


  void onRegisterSuccess() {
    cubit.saveUserData(
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
    );
    Fluttertoast.showToast(msg: "Account Created!");
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  onStateChange(state) {

    if(state is RegisterSuccessState){
      onRegisterSuccess();

    }else if(state is RegisterFailureState){
      Fluttertoast.showToast(msg: state.errorMessage);
    }
  }

