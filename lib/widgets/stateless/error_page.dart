import 'package:flutter/material.dart';
import 'package:student_app/config/string/string_app.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/service/size_screen.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(SizeScreen.sizeSpace / 2),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Expanded(
                  flex: 1,
                  child: Image(
                    image: AssetImage(ImgAssets.error),
                  ),
                ),
                Expanded(flex: 1, child: ErrorText())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text(
          StringApp.someThingWrong,
          style: AppTextStyles.h3,
          textAlign: TextAlign.center,
        ),
        Text(
          StringApp.encouragement,
          style: AppTextStyles.h5,
          textAlign: TextAlign.center,
        ),
        Text(
          StringApp.pleaseTryAgain,
          style: AppTextStyles.h5,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
