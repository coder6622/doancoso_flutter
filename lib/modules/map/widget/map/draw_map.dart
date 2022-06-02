import 'dart:async';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/model/map/list_building.dart';
import 'package:student_app/modules/map/screen/body_sheet.dart';
import 'package:student_app/modules/map/widget/360/display_image_library_out.dart';
import 'package:student_app/modules/map/widget/map/draw_marker.dart';
// import 'package:student_app/modules/map/widget/map/marker.dart';
import 'package:student_app/modules/map/widget/map/theme_map.dart';
import 'package:student_app/modules/map/widget/polygine/directions.dart';
import 'package:student_app/modules/map/widget/polygine/directions_repository.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'package:student_app/service/size_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_app/model/map/building.dart';
import 'dart:developer' as devtools show log;

@immutable
class GoogleMapScreen extends StatefulWidget {
  final bool hideMarkers;
  static bool isFirstPress = true;
  static GoogleMapController? mapController;
  static Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  static LatLng? source;
  static LatLng? des;
  const GoogleMapScreen({Key? key, required this.hideMarkers})
      : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();

  static Future<void> animateToLocation(
      int delay, LatLng newlatlang, double zoom) async {
    Future.delayed(Duration(milliseconds: delay), () {
      mapController
          ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: newlatlang,
        zoom: zoom,
      )));
    });
  }

  static Future<void> _showModal(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 1200), () {
      showModalBottomSheet<void>(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          backgroundColor: Colors.white,
          isScrollControlled: true,
          isDismissible: false,
          context: context,
          builder: (context) {
            return BodySheet();
          });
    });
  }

  static void tapMarker(BuildContext context, LatLng newlatlang) async {
    // double zoom = 19;
    // mapController
    //     ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //       target: newlatlang,
    //       zoom: zoom,
    //     )))
    //     .then((value) => _showModal(context));
    if (GoogleMapScreen.des == null && GoogleMapScreen.source == null) {
      GoogleMapScreen.source = newlatlang;
      devtools.log(GoogleMapScreen.source!.latitude.toString() +
          GoogleMapScreen.source!.longitude.toString());
    } else if (GoogleMapScreen.des == null && GoogleMapScreen.source != null) {
      GoogleMapScreen.des = newlatlang;
      devtools.log(GoogleMapScreen.des!.latitude.toString() +
          GoogleMapScreen.des!.longitude.toString());
    } else if (GoogleMapScreen.des != null && GoogleMapScreen.source != null) {
      GoogleMapScreen.des = null;
      // devtools.log(GoogleMapScreen.des!.latitude.toString() +
      //     GoogleMapScreen.des!.longitude.toString());
      GoogleMapScreen.source = newlatlang;
      devtools.log(GoogleMapScreen.source!.latitude.toString() +
          GoogleMapScreen.source!.longitude.toString());
    }
  }
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final List<Building> buildings = ListBuildings.listBuildings;
  Building? building;
  int isMarkerTaped = -1;
  String markerFlag = '';
  MarkerId idMarkerTapPrev = const MarkerId('');
  String nameMarkerPrev = '';
  late BitmapDescriptor iconTapPrevious;
  late LatLng currentCameraPosition;
  MapType _currentMapType = MapType.normal;
  String _currentTextMapType = 'Statelite view';
  Icon _isZoom = const Icon(Icons.zoom_in_map_sharp);
  bool _isZoomed = false;
  Directions? _info;

  @override
  void initState() {
    _createMarker();
    setState(() {
      building = BuildingAction.buildingSelected;
    });
    super.initState();
  }

  void changeColorMarkerOnTap(MarkerId markerId, BitmapDescriptor iconOnTap) {
    if (MarkerId(markerFlag) != markerId) {
      setState(() {
        if (markerFlag == '') {
          idMarkerTapPrev = markerId;
          nameMarkerPrev = BuildingAction.buildingSelected.name;
        }
        GoogleMapScreen.markers.update(idMarkerTapPrev,
            (value) => value.copyWith(iconParam: iconTapPrevious));
        GoogleMapScreen.markers
            .update(markerId, (value) => value.copyWith(iconParam: iconOnTap));
        idMarkerTapPrev = markerId;
        nameMarkerPrev = BuildingAction.buildingSelected.name;
        markerFlag = markerId.toString();
      });
    }
  }

  void _createMarker() async {
    for (var item in buildings) {
      final BitmapDescriptor icon = await createCustomMarkerBitmap(
          item.name.toString(),
          textStyle: AppTextStyles.h2.copyWith(color: Colors.white),
          backgroundColor: AppColors.orangeryYellow);
      final BitmapDescriptor iconOnTap = await createCustomMarkerBitmap(
          item.name.toString(),
          textStyle: AppTextStyles.h1.copyWith(color: Colors.white),
          backgroundColor: AppColors.mainColor);
      final MarkerId markerId = MarkerId(item.id);
      // creating a new MARKER
      final Marker marker = Marker(
        markerId: markerId,
        icon: icon,
        position: LatLng(
          item.geo.latitude,
          item.geo.longitude,
        ),
        onTap: () {
          // if (!GoogleMapScreen.isFirstPress) {
          //   var snackBar = const SnackBar(content: Text('Please waiting'));
          //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //   Future.delayed(const Duration(milliseconds: 500), () {
          //     ScaffoldMessenger.of(context).removeCurrentSnackBar();
          //   });
          //   return;
          // }
          // GoogleMapScreen.isFirstPress = false;
          // iconTapPrevious = await createCustomMarkerBitmap(nameMarkerPrev,
          //     textStyle: AppTextStyles.h2.copyWith(color: Colors.white),
          //     backgroundColor: AppColors.orangeryYellow);
          setState(() {
            BuildingAction.buildingSelected = item;
          });
          // changeColorMarkerOnTap(markerId, iconOnTap);
          LatLng newlatlang = LatLng(
            BuildingAction.buildingSelected.geo.latitude,
            BuildingAction.buildingSelected.geo.longitude,
          );
          setState(() {
            GoogleMapScreen.tapMarker(context, newlatlang);
          });
        },
      );
      setState(() {
        GoogleMapScreen.markers[markerId] = marker;
      });
    }
  }

  void _onMapCreated(GoogleMapController gController) async {
    gController.setMapStyle(ThemeMap.mapStyle);
    setState(() {
      GoogleMapScreen.mapController = gController;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Stack(children: [
      GoogleMap(
          mapType: _currentMapType,
          onMapCreated: _onMapCreated,
          onCameraMove: (CameraPosition position) {
            currentCameraPosition =
                LatLng(position.target.latitude, position.target.longitude);
          },
          myLocationButtonEnabled: false,
          compassEnabled: false,
          padding: EdgeInsets.only(bottom: SizeScreen.sizeBox * 1.7),
          mapToolbarEnabled: false,
          zoomGesturesEnabled: true,
          tiltGesturesEnabled: false,
          zoomControlsEnabled: false,
          indoorViewEnabled: false,
          initialCameraPosition: CameraPosition(
            target:
                LatLng(buildings[0].geo.latitude, buildings[0].geo.longitude),
            zoom: 18,
          ),
          polylines: {
            if (_info != null)
              Polyline(
                polylineId: const PolylineId('overview_polyline'),
                color: Colors.red,
                width: 5,
                points: _info!.polylinePoints
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              ),
          },
          markers: widget.hideMarkers
              ? {}
              : Set<Marker>.of(GoogleMapScreen.markers.values),
          onTap: (LatLng value) async {
            // final MarkerId markerId =
            //     MarkerId(BuildingAction.buildingSelected.id);
            // final BitmapDescriptor icon = await createCustomMarkerBitmap(
            //     BuildingAction.buildingSelected.name.toString(),
            //     textStyle: AppTextStyles.h2.copyWith(color: Colors.white),
            //     backgroundColor: AppColors.orangeryYellow);
            // if (markerFlag != '') {
            //   setState(() {
            //     GoogleMapScreen.markers.update(
            //         markerId, (value) => value.copyWith(iconParam: icon));
            //     markerFlag = '';
            //   });
            // }
            // devtools.log(value.toString());
          }),
      if (_info != null)
        Positioned(
          top: 20.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                )
              ],
            ),
            child: Text(
              '${_info!.totalDistance}, ${_info!.totalDuration}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

      Positioned(
        bottom: SizeScreen.sizeBox * 6,
        right: SizeScreen.sizeSpace * 2,
        child: MaterialButton(
          shape: const CircleBorder(),
          color: Colors.white,
          padding: const EdgeInsets.all(12),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => const Image360()),
              ),
            );
          },
          child: const Icon(
            Icons.directions,
            color: Colors.blue,
          ),
        ),
      ),

      Positioned(
        bottom: SizeScreen.sizeBox * 4,
        right: SizeScreen.sizeSpace * 2,
        child: MaterialButton(
          shape: const CircleBorder(),
          color: Colors.white,
          padding: const EdgeInsets.all(12),
          onPressed: () async {
            final directions = await DirectionRepository().getDirections(
                origin: GoogleMapScreen.source!,
                destination: GoogleMapScreen.des!);
            setState(() => _info = directions);
          },
          child: const Icon(
            Icons.directions,
            color: Colors.red,
          ),
        ),
      ),
      //nut zoom
      Positioned(
        bottom: SizeScreen.sizeBox * 2 + SizeScreen.sizeSpace,
        right: SizeScreen.sizeSpace * 2,
        child: MaterialButton(
          shape: const CircleBorder(),
          color: Colors.white,
          padding: const EdgeInsets.all(12),
          onPressed: () {
            setState(() {
              if (_isZoom.icon == Icons.zoom_in_map_sharp) {
                _isZoom = const Icon(Icons.zoom_out_map_sharp);
              } else {
                _isZoom = const Icon(Icons.zoom_in_map_sharp);
              }
              _isZoomed = !_isZoomed;
            });
            if (_isZoomed) {
              GoogleMapScreen.animateToLocation(0, currentCameraPosition, 22);
            } else {
              GoogleMapScreen.animateToLocation(0, currentCameraPosition, 18);
            }
          },
          child: _isZoom,
        ),
      ),

      //nut chuyen view
      Positioned(
        bottom: SizeScreen.sizeSpace * 2.5,
        right: SizeScreen.sizeSpace * 2.5,
        child: FloatingActionButton.extended(
          label: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.greyBlur,
          ),
          backgroundColor: Colors.white,
          icon: Text(
            _currentTextMapType,
            style: AppTextStyles.h5.copyWith(color: AppColors.greyBlur),
          ),
          onPressed: () {
            setState(
              () {
                _currentMapType = (_currentMapType == MapType.normal)
                    ? MapType.satellite
                    : MapType.normal;
                _currentTextMapType = (_currentTextMapType == 'Statelite view')
                    ? 'Normal view'
                    : 'Statelite view';
              },
            );
          },
        ),
      )
    ]);
  }
}
