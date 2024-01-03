import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:experiancelogin/cubit/cubit.dart';
import 'package:experiancelogin/cubit/state.dart';
import 'package:experiancelogin/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeAppCubit, HomeAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeAppCubit.get(context).homeModel != null,
          //  &&HomeAppCubit.get(context).categoriesModel != null,
          builder: (context) => builderWidget(
            HomeAppCubit.get(context).homeModel,
            // HomeAppCubit.get(context).categoriesModel, context
          ),
          fallback: (context) => const Center(
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget builderWidget(
    HomeModel? model,
    // CategoriesModel categoriesModel, context
  ) =>
      Column(
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
              height: 200,
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
          const Text('Hellow'),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                  model.data!.products!.length,
                  (index) => GridProductItem(model.data!.products![index]),
                ),
              ),
            ],
          ),
          const Text('Hellow'),
        ],
      );
}

Widget GridProductItem(ProductsModel model) => Column(
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          fit: BoxFit.cover,
          width: 50,
          height: 50,
          // width: double.infinity,
        )
      ],
    );

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeAppCubit, HomeAppStates>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         HomeModel? model;
//         return SingleChildScrollView(
//           child: Column(
//             children: [
//               CarouselSlider(
//                 items: HomeAppCubit.get(context)
//                     .homeModel
//                     ?.data
//                     ?.banners
//                     ?.map(
//                       (e) => Image(
//                         image: NetworkImage('${e.image!}'),
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                       ),
//                     )
//                     .toList(),
//                 options: CarouselOptions(
//                   height: 250,
//                   autoPlay: true,
//                   autoPlayAnimationDuration: Duration(seconds: 1),
//                   initialPage: 0,
//                   viewportFraction: 1,
//                   enableInfiniteScroll: true,
//                   autoPlayInterval: Duration(seconds: 3),
//                   autoPlayCurve: Curves.linear,
//                   scrollDirection: Axis.horizontal,
//                   // animateToClosest: false
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               )
// // ,              Container(
// //                 color: activeColor,
// //                 child: GridView.count(
// //                   physics: NeverScrollableScrollPhysics(),
// //                   shrinkWrap: true,
// //                   crossAxisCount: 2,
// //                   children: [
// //                     grigPorductItem(),
// //                     grigPorductItem(),
// //                     grigPorductItem(),
// //                     grigPorductItem(),
// //                     grigPorductItem(),
// //                     grigPorductItem(),
// //                     grigPorductItem(),
// //                     grigPorductItem(),
// //                     grigPorductItem(),
// //                     grigPorductItem(),
// //                     grigPorductItem()
// //                   ],
// //                 ),
// //               ),
//               ,
//               GridView.count(
//                 crossAxisCount: 2,
//                 children:
//                   List.generate(
//                     model!.data!.products!.length,
//                     (index) => GridProductItem(model.data!.products![index]),
//                   ),

//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }



// // Widget grigPorductItem() {
// //   return Padding(
// //     padding: const EdgeInsets.all(8.0),
// //     child: Container(
// //       height: 200,
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(25),
// //       ),
// //       clipBehavior: Clip.antiAliasWithSaveLayer,
// //       child: Stack(
// //         alignment: Alignment.bottomCenter,
// //         children: [
// //           Image(
// //             image: AssetImage('assets/images/on_boarding_1.jpg'),
// //             fit: BoxFit.cover,
// //             height: double.infinity,
// //           ),
// //           Container(
// //             height: 90,
// //             color: Colors.white,
// //           )
// //         ],
// //       ),
// //     ),
// //   );
// // }
