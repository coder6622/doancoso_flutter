import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/modules/map/widget/360/custom_hotspot.dart';
import 'package:student_app/modules/map/widget/360/display_image_library_in.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../service/size_screen.dart';

class PanoramaLibraryOut extends StatefulWidget {
  const PanoramaLibraryOut({Key? key}) : super(key: key);

  @override
  State<PanoramaLibraryOut> createState() => _PanoramaLibraryOutState();
}

class _PanoramaLibraryOutState extends State<PanoramaLibraryOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Panorama(
              longitude: 40,
              minLatitude: -25,
              maxLatitude: 25,
              sensitivity: 2.0,
              animSpeed: 0.0,
              latSegments: 32,
              lonSegments: 64,
              zoom: 0,
              child: Image.asset('assets/images/library360/thuvienNgoai.jpg'),
              hotspots: [
                Hotspot(
                  latitude: 18,
                  longitude: -88,
                  width: 90,
                  height: SizeScreen.sizeBox * 2.5,
                  widget: CustomHotspot(
                      text: "Đi vào",
                      icon: Icons.open_in_browser,
                      // onPressed: () => Navigator.of(context).push(
                      //     MaterialPageRoute(
                      //         builder: ((context) => const PanoramaLibraryIn()))),
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PanoramaLibraryIn(),
                          ))),
                ),
              ],
              // child: Image.network(
              //     'https://images.pexels.com/photos/207385/pexels-photo-207385.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
            ),
            Positioned(
              bottom: SizeScreen.sizeSpace * 2.5,
              right: SizeScreen.sizeSpace * 2.5,
              child: FloatingActionButton.extended(
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.greyBlur,
                ),
                backgroundColor: Colors.white,
                label: Text(
                  'Thoát',
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.greyBlur,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
