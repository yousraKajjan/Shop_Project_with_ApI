import 'package:experiancelogin/cubit/cubit.dart';
import 'package:experiancelogin/cubit/state.dart';
import 'package:experiancelogin/models/favourite_model.dart';
import 'package:experiancelogin/shared/constante/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeAppCubit, HomeAppStates>(
      listener: (context, state) => {},
      builder: (context, state) => ListView.separated(
          itemBuilder: (context, index) => buildFavItem(
              HomeAppCubit.get(context)
                  .favoritesModel!
                  .data!
                  .data![index]
                  .product,
              context),
          separatorBuilder: (context, index) => const Divider(),
          itemCount:
              HomeAppCubit.get(context).favoritesModel!.data!.data!.length),
    );
  }

  Widget buildFavItem(model, context) => SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(
                          '${model!.image}'), // width: double.infinity,
                      height: 200,
                      width: 200,
                      // fit: BoxFit.cover,
                    ),
                    if ('${model.discount}' != 0)
                      Container(
                        color: Colors.red,
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 5, vertical: 5),
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              letterSpacing: 3),
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          height: 1.3,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.price.toString()}\$',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.green[400]),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if ('${model.discount}' != 0)
                          Text(
                            '${model.oldPrice.toString()}\$',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: defaultColor,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        //Favourites
                        IconButton(
                          onPressed: () {
                            HomeAppCubit.get(context).ChangeFavorites(model.id);
                            // print('${model.inFavorites}');
                          },
                          icon: CircleAvatar(
                            backgroundColor: HomeAppCubit.get(context)
                                            .favourites[model.id] !=
                                        null &&
                                    HomeAppCubit.get(context)
                                            .favourites[model.id] ==
                                        true
                                ? Colors.amber
                                : Colors.grey,
                            radius: 15,
                            child: const Icon(
                              Icons.favorite_outline,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
