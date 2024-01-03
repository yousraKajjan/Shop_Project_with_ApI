import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:experiancelogin/cubit/cubit.dart';
import 'package:experiancelogin/cubit/state.dart';
import 'package:experiancelogin/shared/network/components/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeAppCubit, HomeAppStates>(
      listener: (context, state) {
        //ما تلعب على ال stat حاول دائما العب على ال  modle
        // if (state is GetUserDataSuccessState) {
        //   nameController.text = state.userModel!.data!.name!;
        //   emailController.text = state.userModel!.data!.email!;
        //   nameController.text = state.userModel!.data!.phone!;
        // }
      },
      builder: (context, state) {
        var modle = HomeAppCubit.get(context).userModel;
        nameController.text = modle!.data!.name!;
        emailController.text = modle.data!.email!;
        phoneController.text = modle.data!.phone!;
        return ConditionalBuilder(
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          condition: HomeAppCubit.get(context).userModel != null,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      child: ClipOval(
                        child: Image(image: NetworkImage(modle.data!.image!)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        label: Text('Your Nmae is:'),
                        //hintText: 'Email',
                        prefixIcon: Icon(Icons.person),
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
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        label: Text('Your Phone'),
                        // hintText: 'Email',
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
                    if (state is UpdatUserLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        HomeAppCubit.get(context).UpdateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text);
                      },
                      child: const Text('Update'),
                    ),
                    TextButton(
                      onPressed: () {
                        signOut(context);
                      },
                      child: const Text('LOGOUT'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
