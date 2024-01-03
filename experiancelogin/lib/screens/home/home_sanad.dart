import 'package:experiancelogin/cubit/cubit.dart';
import 'package:experiancelogin/cubit/state.dart';
import 'package:experiancelogin/shared/constante/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeAppCubit, HomeAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                  items: HomeAppCubit.get(context)
                      .homeModel
                      ?.data
                      ?.banners
                      ?.map((e) => Image(
                            image: NetworkImage(e.image!),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    initialPage: 1,
                    viewportFraction: 0.4,
                  )),
              Container(
                color: activeColor,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    grigPorductItem(),
                    grigPorductItem(),
                    grigPorductItem(),
                    grigPorductItem(),
                    grigPorductItem(),
                    grigPorductItem(),
                    grigPorductItem(),
                    grigPorductItem(),
                    grigPorductItem(),
                    grigPorductItem(),
                    grigPorductItem()
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget grigPorductItem() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: AssetImage('assests/images/onboard_1.png'),
            // image:NetworkImage(model),
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            height: 90,
            color: Colors.white,
          )
        ],
      ),
    ),
  );
}
