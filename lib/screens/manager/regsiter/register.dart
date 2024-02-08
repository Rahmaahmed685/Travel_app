import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/screens/bar_item_pages/home_screen.dart';
import 'package:travel_app/screens/manager/regsiter/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final titleController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  final cubit = RegisterCubit();

bool isFavorite =false;
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
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(
                      context, (MaterialPageRoute(
                      builder: (context) => HomeScreen())));
                },
                    icon: Icon(Icons.ice_skating))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  IconButton(onPressed: (){
                    setState(() {
                      isFavorite =true;
                    });
                  },
                      icon: Icon(Icons.favorite)),
                  TextFormField(
                    controller: addressController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  TextFormField(
                    controller: titleController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'title',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
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
      title: titleController.text,
      address: addressController.text,
      email: emailController.text,
    );
    print('accont created');
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  onStateChange(state) {
    if (state is RegisterSuccessState) {
      onRegisterSuccess();
    } else if (state is RegisterFailureState) {
      print("error=>" + state.errorMessage);
      ;
    }
  }
}
