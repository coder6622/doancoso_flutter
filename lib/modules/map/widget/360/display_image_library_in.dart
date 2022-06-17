import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:student_app/modules/map/widget/360/custom_hotspot.dart';
import 'package:student_app/modules/map/widget/360/image_room_library.dart';
import 'package:student_app/service/size_screen.dart';
import 'dart:developer' as devtools show log;

class PanoramaLibraryIn extends StatefulWidget {
  const PanoramaLibraryIn({Key? key}) : super(key: key);

  @override
  State<PanoramaLibraryIn> createState() => _PanoramaLibraryInState();
}

class _PanoramaLibraryInState extends State<PanoramaLibraryIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Panorama(
        // latitude: ,
        onTap: (longitude, latitude, tilt) =>
            devtools.log('onTap: $longitude, $latitude, $tilt'),
        longitude: -0.01,
        minLatitude: -25,
        maxLatitude: 25,
        animSpeed: 0.0,
        sensitivity: 2.0,
        sensorControl: SensorControl.None,
        child: Image.asset('assets/images/library360/thuvienTrong.jpg'),
        hotspots: [
          Hotspot(
            latitude: -15,
            longitude: -40,
            width: SizeScreen.sizeBox * 3,
            height: SizeScreen.sizeBox * 2.5,
            widget: CustomHotspot(
              text: "Đi ra",
              icon: Icons.open_in_browser,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Hotspot(
            latitude: 9.58284818101943,
            longitude: 34.98731387497386,
            width: SizeScreen.sizeBox * 3,
            height: SizeScreen.sizeBox * 2.5,
            widget: CustomHotspot(
              text: "Phòng TH",
              icon: Icons.open_in_browser,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PanoramaRoomLibrary(),
              )),
            ),
          ),
        ],
      ),
    ));
  }
}
