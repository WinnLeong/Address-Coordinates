import 'package:address_coordinates/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

class Details extends StatelessWidget {
  final List<Location> coordinates;
  final List<Placemark> address;

  Details(this.coordinates, this.address);

  final customSnackBar = CustomSnackbar();

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
                  '${address[0].street}, ${address[0].postalCode} ${address[0].locality}, ${address[0].administrativeArea}, ${address[0].country}'),
            ),
            InkWell(
              onTap: () {
                Clipboard.setData(
                  ClipboardData(
                      text:
                          '${address[0].street}, ${address[0].postalCode} ${address[0].locality}, ${address[0].administrativeArea}, ${address[0].country}'),
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
                  '${coordinates[0].latitude}, ${coordinates[0].longitude}'),
            ),
            InkWell(
              onTap: () {
                Clipboard.setData(
                  ClipboardData(
                      text:
                          '${coordinates[0].latitude}, ${coordinates[0].longitude}'),
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
      final coords = Coords(coordinates[0].latitude, coordinates[0].longitude);
      final availableMaps = await MapLauncher.installedMaps;

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
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
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
        title: Text('Information'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (address.length > 0) renderAddress(context),
            SizedBox(height: 20.h),
            if (coordinates.length > 0) renderCoordinates(context),
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
