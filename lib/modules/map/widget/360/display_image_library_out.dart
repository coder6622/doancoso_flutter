import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:student_app/modules/map/widget/360/display_image_library_in.dart';


class Image360 extends StatefulWidget {
  const Image360({Key? key}) : super(key: key);

  @override
  State<Image360> createState() => _Image360State();
}

class _Image360State extends State<Image360> {
  double _lon = 0;

  double _lat = 0;

  double _tilt = 0;

  int _panoId = 0;

  List<Image> panoImages = [
    Image.asset('assets/images/library/Thuvien0.jpg'),
    Image.asset('assets/images/library/Thuvien1.jpg'),
    Image.asset('assets/images/library/Thuvien2.jpg'),
  ];

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
    });
  }

  Widget hotspotButton(
      {String? text, IconData? icon, VoidCallback? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const CircleBorder()),
            backgroundColor: MaterialStateProperty.all(Colors.black38),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Icon(icon),
          onPressed: onPressed,
        ),
        text != null
            ? Container(
                padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(child: Text(text)),
              )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Panorama(
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
        child: Image.asset('assets/images/library/Thuvien0.jpg'),
        hotspots: [
          Hotspot(
            latitude: 10.0,
            longitude: -65,
            width: 90,
            height: 75,
            widget: hotspotButton(
                text: "Đi vào",
                icon: Icons.open_in_browser,
                onPressed: () => setState(() => Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const ImageLibrary()))),
          ),))
        
          
        ],
      ),
    ));
  }
}
