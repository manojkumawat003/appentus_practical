import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class MapHomeScreen extends StatefulWidget {
  @override
  _MapHomeScreenState createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
   LatLng?  currentLatLang = LatLng(35.68, 51.41) ;
  MapController  controller = MapController(
    location: LatLng(35.68, 51.41),
  );



  @override
  void initState() {
    
    _getCurrentLocation();
    super.initState();
  }

   _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
    if(mounted){
      setState(() {
     
   currentLatLang = LatLng(position.latitude,position.longitude);
      
     controller =  MapController(
    location:  LatLng(position.latitude,position.longitude),
  );
      });
        
     }
    }).catchError((e) {
      print(e);
    });
  }


  void _gotoDefault() {
   _getCurrentLocation();
  }

  void _onDoubleTap() {
    controller.zoom += 0.5;
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  Widget _buildMarkerWidget(Offset pos, Color color) {
    return  Positioned(
      left: pos.dx - 16,
      top: pos.dy - 16,
    
      child: Icon(Icons.location_on, color: color,size: 50,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: MapLayoutBuilder(
        controller: controller,
        builder: (context, transformer) {
        
          final homeLocation =
              transformer.fromLatLngToXYCoords(currentLatLang!);

          final homeMarkerWidget =
              _buildMarkerWidget(homeLocation, Colors.red);

          
     

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onDoubleTap: _onDoubleTap,
            onScaleStart: _onScaleStart,
            onScaleUpdate: _onScaleUpdate,
            onTapUp: (details) {
              final location =
                  transformer.fromXYCoordsToLatLng(details.localPosition);

              final clicked = transformer.fromLatLngToXYCoords(location);

              print('${location.longitude}, ${location.latitude}');
              print('${clicked.dx}, ${clicked.dy}');
              print('${details.localPosition.dx}, ${details.localPosition.dy}');
            },
            child: Listener(
              behavior: HitTestBehavior.opaque,
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  final delta = event.scrollDelta;

                  controller.zoom -= delta.dy / 500.0;
                  setState(() {});
                }
              },
              child: Stack(
                children: [
                  Map(
                    controller: controller,
                    builder: (context, x, y, z) {
                      //Legal notice: This url is only used for demo and educational purposes. You need a license key for production use.

                      //Google Maps
                      final url =
                          'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                           return Image.network(
 url,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  homeMarkerWidget,
          
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _gotoDefault,
        tooltip: 'Current Location',
        child: Icon(Icons.my_location),
      ),
    );
  }
}