import 'package:address_coordinates/utils/custom_button.dart';
import 'package:address_coordinates/utils/custom_text_form_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

import 'router.gr.dart';
import 'utils/loading_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  bool _isVisible = false;

  @override
  void dispose() {
    addressController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  _verify() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScope.of(context).requestFocus(new FocusNode());

      setState(() {
        _isVisible = true;
      });

      List<Location> getCoordinates = [];
      List<Placemark> getAddress = [];

      getCoordinates = await locationFromAddress(addressController.text);

      if (latitudeController.text.isNotEmpty &&
          longitudeController.text.isNotEmpty)
        getAddress = await placemarkFromCoordinates(
          double.tryParse(latitudeController.text),
          double.tryParse(longitudeController.text),
        );

      setState(() {
        _isVisible = false;
      });

      ExtendedNavigator.of(context).push(
        Routes.details,
        arguments: DetailsArguments(
          coordinates: getCoordinates,
          address: getAddress,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(
                            fontSize: 40.sp, fontWeight: FontWeight.bold),
                      ),
                      CustomTextFormField(
                        hintText: 'Address',
                        controller: addressController,
                        validator: (value) {
                          if (value.isEmpty &&
                              latitudeController.text.isEmpty &&
                              longitudeController.text.isEmpty) {
                            return 'Enter address or coordinates.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        'Coordinates',
                        style: TextStyle(
                            fontSize: 40.sp, fontWeight: FontWeight.bold),
                      ),
                      CustomTextFormField(
                        hintText: 'Latitude',
                        controller: latitudeController,
                        validator: (value) {
                          if (value.isEmpty &&
                              longitudeController.text.isNotEmpty) {
                            return 'Both latitude and longitude is required.';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        hintText: 'Longitude',
                        controller: longitudeController,
                        validator: (value) {
                          if (value.isEmpty &&
                              latitudeController.text.isNotEmpty) {
                            return 'Both latitude and longitude is required.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      Center(
                        child: CustomButton(
                            buttonColor: Colors.blue,
                            onPressed: _verify,
                            title: 'Convert'),
                      ),
                    ],
                  ),
                ),
              ),
              LoadingModel(
                isVisible: _isVisible,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
