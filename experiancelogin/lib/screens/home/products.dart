import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:experiancelogin/cubit/cubit.dart';
import 'package:experiancelogin/cubit/state.dart';
import 'package:experiancelogin/models/categories_model.dart';
import 'package:experiancelogin/models/home_model.dart';
import 'package:experiancelogin/shared/constante/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeAppCubit, HomeAppStates>(
      listener: (context, state) {
        if (state is ChangeFavouritesSuccessState) {
          if (state.modle.status == false) {
            print(state.modle.message);
          }
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ConditionalBuilder(
            condition: HomeAppCubit.get(context).homeModel != null &&
                HomeAppCubit.get(context).categoriesModel != null,
            builder: (context) => ProductBuilder(
                HomeAppCubit.get(context).homeModel,
                HomeAppCubit.get(context).categoriesModel,
                context),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

Widget ProductBuilder(
    HomeModel? model, CategoriesModel? categoriesModel, context) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model!.data!.banners!
              .map(
                (e) => Image(
                  image: NetworkImage('${e.image}'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 250,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        BuildCategoriesItem(categoriesModel.data!.data[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: categoriesModel!.data!.data.length),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'New-Products',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1 / 1.5, //hiegt/width

            children: List.generate(
              model.data!.products!.length,
              (index) => GridProductItem(model.data!.products![index], context),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget GridProductItem(ProductsModel model, context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                // width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 5, vertical: 5),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 10, color: Colors.white, letterSpacing: 3),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, height: 1.3, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}\$',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[400]),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}\$',
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
                        backgroundColor:
                            HomeAppCubit.get(context).favourites[model.id] !=
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
    );

Widget BuildCategoriesItem(DataModel model) => Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.8),
          child: Text(
            '${model.name}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
