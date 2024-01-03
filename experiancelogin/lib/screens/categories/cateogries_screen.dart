import 'package:experiancelogin/cubit/cubit.dart';
import 'package:experiancelogin/cubit/state.dart';
import 'package:experiancelogin/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeAppCubit, HomeAppStates>(
      listener: (context, state) => {},
      builder: (context, state) => ListView.separated(
          itemBuilder: (context, index) => BuildCatItem(
              HomeAppCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context, index) => const Divider(),
          itemCount:
              HomeAppCubit.get(context).categoriesModel!.data!.data.length),
    );
  }

  Widget BuildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              '${model.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
