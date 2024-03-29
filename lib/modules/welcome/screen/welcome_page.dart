// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:student_app/modules/home/screen/home_page.dart';
import 'package:student_app/service/size_screen.dart';

import '../../../config/themes/app_colors.dart';
import '../../../constants/assets_part.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    _navigatorHome();
  }

  _navigatorHome() async {
    // await FakeDataMap().totalAddBuilding();
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    SizeScreen().getSize(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Center(
        child: Container(
          child: Image.asset(ImgAssets.logo),
        ),
      ),
    );
  }
}
