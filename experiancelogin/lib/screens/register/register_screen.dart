import 'package:experiancelogin/layout/home_layout.dart';
import 'package:experiancelogin/screens/register/cubit/cubit.dart';
import 'package:experiancelogin/screens/register/cubit/state.dart';
import 'package:experiancelogin/shared/network/components/constans.dart';
import 'package:experiancelogin/shared/network/local/cache_helper.dart';
import 'package:experiancelogin/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) if (state.model.status == true) {
            CashHelper.saveData(key: 'token', value: state.model.data!.token)
                .then((value) {
              token = state.model.data!.token!;
              navigatAndFinishTo(context, HomeLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Register'),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
              child: SingleChildScrollView(
                child: Column(children: [
                  Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[200],
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      label: Text('You Name'),
                      hintText: 'Enter You Name please',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                      //hintText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('Password'),
                      //hintText: 'Email',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.remove_red_eye_outlined,
                      ),
                    ),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      label: Text('Your phone'),
                      hintText: 'Enter You phone please',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (state is RegisterLoadingState)
                    const LinearProgressIndicator(),
                  MaterialButton(
                    onPressed: () {
                      RegisterCubit.get(context).userRegister(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          phone: phoneController.text);
                    },
                    minWidth: double.infinity,
                    height: 20,
                    color: Colors.amber[100],
                    child: const Center(
                      child: Text(
                        'Register',
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
