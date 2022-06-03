import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/modules/map/widget/360/display_image_library_out.dart';
import 'package:student_app/modules/map/widget/common_used/hour_caculate.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'package:student_app/service/size_screen.dart';

class TextAbout extends StatelessWidget {
  const TextAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: AutoSizeText(
            BuildingAction.buildingSelected.name,
            style: AppTextStyles.h2.copyWith(color: Colors.black),
            maxLines: 1,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: AutoSizeText(
            BuildingAction.buildingSelected.usesPlace,
            style: AppTextStyles.h4.copyWith(color: AppColors.greyBlur),
            maxLines: 1,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 10,
              fit: FlexFit.loose,
              child: Align(
                alignment: Alignment.topLeft,
                child: HourOpenClose(
                  isSizeBoxBefore: false,
                  isBorder: false,
                  isPadding: false,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: IconButton(
                icon: Image.asset(
                  ImgAssets.logoImage360,
                  width: SizeScreen.sizeIcon * 3,
                  height: SizeScreen.sizeIcon * 3,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const Image360()),
                    ),
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
