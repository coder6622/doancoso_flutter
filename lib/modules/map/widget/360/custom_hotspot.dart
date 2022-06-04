import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/service/size_screen.dart';

class CustomHotspot extends StatelessWidget {
  String? text;
  IconData? icon;
  VoidCallback? onPressed;
  CustomHotspot({
    Key? key,
    this.text,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            child: Icon(icon),
          ),
          SizedBox(
            height: SizeScreen.sizeSpace,
          ),
          text != null
              ? Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: const BoxDecoration(
                      color: AppColors.orangeryYellow,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Center(
                    child: Text(
                      text!,
                      style: AppTextStyles.h3.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
