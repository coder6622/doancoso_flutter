import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:student_app/modules/map/widget/360/custom_hotspot.dart';
import 'package:student_app/service/size_screen.dart';

class ImageLibrary extends StatefulWidget {
  const ImageLibrary({Key? key}) : super(key: key);

  @override
  State<ImageLibrary> createState() => _ImageLibraryState();
}

class _ImageLibraryState extends State<ImageLibrary> {
  double _lon = 0;

  double _lat = 0;

  double _tilt = 0;

  final int _panoId = 0;

  List<Image> panoImages = [
    
    Image.asset('assets/images/library/Thuvien2.jpg'),
  ];

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Panorama(
        latSegments: 16,
        lonSegments: 32,
        animSpeed: 0.0,
        sensitivity: 4.0,
        sensorControl: SensorControl.None,
        onViewChanged: onViewChanged,
        onTap: (longitude, latitude, tilt) =>
            print('onTap: $longitude, $latitude, $tilt'),
        onLongPressStart: (longitude, latitude, tilt) =>
            print('onLongPressStart: $longitude, $latitude, $tilt'),
        onLongPressMoveUpdate: (longitude, latitude, tilt) =>
            print('onLongPressMoveUpdate: $longitude, $latitude, $tilt'),
        onLongPressEnd: (longitude, latitude, tilt) =>
            print('onLongPressEnd: $longitude, $latitude, $tilt'),
        child: Image.asset('assets/images/library/thuvienTrong.jpg'),
        hotspots: [
          Hotspot(
            latitude: 10.0,
            longitude: 0,
            width: SizeScreen.sizeBox * 3,
            height: SizeScreen.sizeBox * 2.5,
            widget: CustomHotspot(
                text: "Đi ra",
                icon: Icons.open_in_browser,
                onPressed: () => setState(() => Navigator.of(context).pop())),
          ),
        
          
        ],
      ),
    ));
  }
}
