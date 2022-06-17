import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:student_app/modules/map/widget/360/custom_hotspot.dart';
import 'package:student_app/service/size_screen.dart';
import 'dart:developer' as devtools show log;

class PanoramaRoomLibrary extends StatefulWidget {
  const PanoramaRoomLibrary({Key? key}) : super(key: key);

  @override
  State<PanoramaRoomLibrary> createState() => _PanoramaRoomLibraryState();
}

class _PanoramaRoomLibraryState extends State<PanoramaRoomLibrary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Panorama(
        // latitude: ,
        // latSegments: 16,
        // lonSegments: 32,
        onTap: (longitude, latitude, tilt) =>
            devtools.log('onTap: $longitude, $latitude, $tilt'),
        // longitude: .01,
        zoom: 0,
        minLatitude: -25,
        maxLatitude: 30,
        minLongitude: -180,
        maxLongitude: 180,
        animSpeed: 0.0,
        sensitivity: 2.0,
        child: Image.asset('assets/images/library360/tvPhong.jpg'),
        hotspots: [
          Hotspot(
            latitude: -50.20618822107546,
            longitude: 149.68202477088278,
            width: SizeScreen.sizeBox * 3,
            height: SizeScreen.sizeBox * 2.5,
            widget: CustomHotspot(
              text: "Đi ra",
              icon: Icons.open_in_browser,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    ));
  }
}
