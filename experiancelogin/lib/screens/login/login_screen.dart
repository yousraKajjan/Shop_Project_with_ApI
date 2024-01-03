import 'package:experiancelogin/layout/home_layout.dart';
import 'package:experiancelogin/screens/login/cubit/cubit.dart';
import 'package:experiancelogin/screens/login/cubit/state.dart';
import 'package:experiancelogin/screens/register/register_screen.dart';
import 'package:experiancelogin/shared/constante/color.dart';
import 'package:experiancelogin/shared/network/components/constans.dart';
import 'package:experiancelogin/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) if (state.model.status == true) {
            CashHelper.saveData(key: 'token', value: state.model.data!.token)
                .then((value) {
              token = state.model.data!.token!;
              navigatAndFinishTo(context, HomeLayout());
            });
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('LOGIN'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
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
                      height: 30,
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
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          cubit.userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                          //navigatAndFinishTo(context, HomeLayout());
                        },
                        padding: const EdgeInsetsDirectional.symmetric(
                          vertical: 20,
                        ),
                        color: activeColor,
                        hoverColor: Colors.black,
                        child: const Text(
                          'login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            height: 1.9,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is LoginLoadingState)
                      const LinearProgressIndicator(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('don\'t have an account!'),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            navigatTo(context, RegisterScreen());
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.2,
                              color: activeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
