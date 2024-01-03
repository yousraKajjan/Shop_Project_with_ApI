import 'package:experiancelogin/layout/home_layout.dart';
import 'package:experiancelogin/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/constante/color.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/widgets/widgets.dart';

class OnBoardModel {
  final String image;
  final String tittle;
  final String body;

  OnBoardModel(this.image, this.tittle, this.body);
}

class OnBoardScreen extends StatelessWidget {
  var pageController = PageController();
  List<OnBoardModel> onboardList = [
    OnBoardModel('assets/images/on_boarding_1.jpg', 'On Board Title Screen 1',
        'On Board Body Screen 1'),
    OnBoardModel('assets/images/on_boarding_2.png', 'On Board Title Screen 2',
        'On Board Body Screen 2'),
    OnBoardModel('assets/images/on_boarding_3.jpg', 'On Board Title Screen 3',
        'On Board Body Screen 3'),
  ];
  int indexPage = 0;
  void submit(context) {
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      navigatAndFinishTo(context, LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) {
                      indexPage = index;
                    },
                    //لوصول إلى نهاية المحتوى الممكن التمرير إليه ، ستظهر تأثيرات الارتداد. بمعنى آخر ، عندما يتم سحب الشاشة أكثر من الحد الأقصى للتمرير ، ستتم إعادة توجيهها بشكل مرتد وستعود إلى مكانها الأصلي.
                    physics: BouncingScrollPhysics(),
                    itemCount: onboardList.length,
                    itemBuilder: (context, index) =>
                        buildPageItem(context, onboardList[index]))),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: SlideEffect(

                      // dotWidth: 50,
                      // dotHeight: 15,
                      // dotColor: Colors.grey,
                      // activeDotColor: activeColor,
                      ),
                  // effect: WormEffect(
                  //   dotWidth: 50,
                  //   dotHeight: 15,
                  //   dotColor: Colors.grey,
                  //   activeDotColor: activeColor,
                  // ),
                  controller: pageController,
                  count: onboardList.length,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    height: 60,
                    child: MaterialButton(
                      onPressed: () {
                        if (indexPage == 2) submit(context);
                        pageController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.linearToEaseOut);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: activeColor,
                      child: Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16, height: 0.7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildPageItem(context, OnBoardModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '${model.tittle}',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      Text(
        '${model.body}',
        style: Theme.of(context).textTheme.labelSmall,
      ),
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
    ],
  );
}
