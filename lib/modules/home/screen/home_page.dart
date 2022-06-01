// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/modules/info_school/screen/info_school_page.dart';
import 'package:student_app/modules/sign_in_sign_up/screen/sign_in_page.dart';
import 'package:student_app/service/size_screen.dart';

import '../../../config/routes/routes.dart';
import '../../../config/themes/app_colors.dart';
import '../../../constants/assets_part.dart';
import '../widget/item_banner.dart';
import '../widget/item_bottombar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeScreen.sizeBox * 2,
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 48, // Image radius
              backgroundImage: AssetImage(ImgAssets.logoTruong),
            ),
            SizedBox(
              height: SizeScreen.sizeSpace,
            ),
            Text(
              'Trường đại học Đà Lạt',
              style: AppTextStyles.h2.copyWith(
                color: AppColors.mainColor,
              ),
            ),
            Text(
              'DALAT UNIVERSITY',
              style: AppTextStyles.h3.copyWith(
                color: AppColors.mainColor,
              ),
            ),
            SizedBox(
              height: SizeScreen.sizeBox,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                height: SizeScreen.sizeHeightScreen / 2,
                child: ListView(
                  children: <Widget>[
                    CarouselSlider(
                      // ignore: prefer_const_literals_to_create_immutables
                      items: [
                        ItemBanner(images: ImgAssets.images1),
                        ItemBanner(images: ImgAssets.images1),
                        ItemBanner(images: ImgAssets.images2),
                        ItemBanner(images: ImgAssets.images3),
                        ItemBanner(images: ImgAssets.images4),
                      ],
                      options: CarouselOptions(
                          height: SizeScreen.sizeHeightScreen / 2,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 0.8),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.lightGreen,
        child: Container(
          height: 64,
          color: Colors.white,
          child: TabBar(
            labelColor: AppColors.mainColor,
            unselectedLabelColor: Colors.white,
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.black54, width: 0),
                insets: EdgeInsets.fromLTRB(50, 0, 40, 40)),

            //For Indicator Show and Custonization
            indicatorColor: Colors.black,
            tabs: <Widget>[
              ItemBottomBar(
                  iconBottomBar: const Icon(Icons.home_outlined), onTap: () {}),
              ItemBottomBar(
                  iconBottomBar: const Icon(Icons.map_outlined),
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.mapPage);
                  }),
              ItemBottomBar(
                  iconBottomBar: const Icon(Icons.interests_outlined),
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        curve: Curves.easeIn,
                        duration: const Duration(milliseconds: 400),
                        child: InfoSchoolPage(),
                      ),
                    );
                  }),
              ItemBottomBar(
                  iconBottomBar: const Icon(Icons.person_outline),
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        curve: Curves.easeIn,
                        duration: const Duration(milliseconds: 400),
                        child: SignInPage(),
                      ),
                    );
                  }),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
