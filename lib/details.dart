// import 'dart:async';

import 'package:address_coordinates/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Details extends StatefulWidget {
  final List<Location> coordinates;
  final List<Placemark> address;

  Details(this.coordinates, this.address);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final customSnackBar = CustomSnackbar();
  /* final Completer<GoogleMapController> mapController = Completer();
  Set<Marker> markers = {};
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(
      3.154430,
      101.715103,
    ),
    zoom: 20,
  ); */

  renderAddress(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address',
          style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 600.w,
              child: SelectableText(
                  '${widget.address[0].street}, ${widget.address[0].postalCode} ${widget.address[0].locality}, ${widget.address[0].administrativeArea}, ${widget.address[0].country}'),
            ),
            InkWell(
              onTap: () {
                Clipboard.setData(
                  ClipboardData(
                      text:
                          '${widget.address[0].street}, ${widget.address[0].postalCode} ${widget.address[0].locality}, ${widget.address[0].administrativeArea}, ${widget.address[0].country}'),
                );

                customSnackBar.show(context,
                    message: 'Address copied to clipboard.',
                    duration: 1000,
                    type: MessageType.INFO);
              },
              child: Icon(Icons.content_copy),
            ),
          ],
        ),
      ],
    );
  }

  renderCoordinates(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Coordinates',
          style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 600.w,
              child: SelectableText(
                  '${widget.coordinates[0].latitude}, ${widget.coordinates[0].longitude}'),
            ),
            InkWell(
              onTap: () {
                Clipboard.setData(
                  ClipboardData(
                      text:
                          '${widget.coordinates[0].latitude}, ${widget.coordinates[0].longitude}'),
                );

                customSnackBar.show(context,
                    message: 'Coordinates copied to clipboard.',
                    duration: 1000,
                    type: MessageType.INFO);
              },
              child: Icon(Icons.content_copy),
            ),
          ],
        ),
      ],
    );
  }

  _openDestination(context) async {
    try {
      final title = 'Venue';
      final description = "";
      final coords = mapLauncher.Coords(
          widget.coordinates[0].latitude, widget.coordinates[0].longitude);
      final availableMaps = await mapLauncher.MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () {
                          map.showMarker(
                            coords: coords,
                            title: title,
                            description: description,
                          );
                        },
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30,
                          width: 30,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geocode'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.address.length > 0) renderAddress(context),
            SizedBox(height: 20.h),
            if (widget.coordinates.length > 0) renderCoordinates(context),
            SizedBox(height: 20.h),
            Center(
              child: RawMaterialButton(
                fillColor: Colors.blue[900],
                shape: CircleBorder(),
                onPressed: () => _openDestination(context),
                child: Icon(
                  Icons.map,
                  color: Colors.white,
                  size: 32,
                ),
                padding: const EdgeInsets.all(13.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* 
GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: cameraPosition,
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              mapController.complete(controller);
            },
          ),
           */
