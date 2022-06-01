// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';

class ItemHome extends StatelessWidget {
  final Icon iconHome;
  final String textHome;
  final VoidCallback onTapTo;
  ItemHome(
      {required this.iconHome, required this.textHome, required this.onTapTo});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 91,
      width: 86,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.mainColor),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: onTapTo,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: Icon(
                iconHome.icon,
                size: 48,
                color: AppColors.mainColor,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5),
              child: Text(textHome, style: AppTextStyles.h5),
            ),
          ],
        ),
      ),
    );
  }
}
