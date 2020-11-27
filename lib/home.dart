import 'package:address_coordinates/utils/custom_button.dart';
import 'package:address_coordinates/utils/custom_text_form_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_webservice/places.dart';

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

  static const kGoogleApiKey = 'AIzaSyDmqPORhCFty3J-ip1yCCqPdCzochLl3Fk';
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  Mode _mode = Mode.overlay;
  // to get places detail (lat/lng)
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  String _countryCode = 'my';

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

      List<geocoding.Location> getCoordinates = [];
      List<geocoding.Placemark> getAddress = [];

      getCoordinates =
          await geocoding.locationFromAddress(addressController.text);

      if (latitudeController.text.isNotEmpty &&
          longitudeController.text.isNotEmpty)
        getAddress = await geocoding.placemarkFromCoordinates(
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

  Future<void> toggleSearchBar() async {
    setState(() {
      addressController.clear();
      latitudeController.clear();
      longitudeController.clear();
    });
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: "en",
      components: [Component(Component.country, _countryCode)],
    );

    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);

    setState(() {
      addressController.text = p.description;
      latitudeController.text = detail.result.geometry.location.lat.toString();
      longitudeController.text = detail.result.geometry.location.lng.toString();
    });
    // displayPrediction(p, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  getCountryCode() {
    return CountryCodePicker(
      onChanged: (value) {
        setState(() {
          _countryCode = value.code;
        });
      },
      initialSelection: 'MY',
      favorite: ['+60', 'MY'],
      showCountryOnly: true,
      showFlagMain: true,
      hideMainText: true,
      alignLeft: false,
      enabled: true,
      textStyle: TextStyle(
        fontSize: 58.sp,
        color: Color(0xff808080),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(750, 1334),
      allowFontScaling: true,
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: homeScaffoldKey,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Address',
                            style: TextStyle(
                                fontSize: 40.sp, fontWeight: FontWeight.bold),
                          ),
                          getCountryCode(),
                        ],
                      ),
                      /* Text(
                        'Address',
                        style: TextStyle(
                            fontSize: 40.sp, fontWeight: FontWeight.bold),
                      ), */
                      InkWell(
                        onTap: toggleSearchBar,
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5.w),
                            hintStyle: TextStyle(
                              color: Color(0xff2f3033),
                            ),
                            hintText: 'Address',
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlue, width: 1.0)),
                          ),
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
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Coordinates',
                        style: TextStyle(
                            fontSize: 40.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
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
