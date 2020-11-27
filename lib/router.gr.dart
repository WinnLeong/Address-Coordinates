// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'details.dart';
import 'home.dart';

class Routes {
  static const String home = '/Home';
  static const String details = '/Details';
  static const all = <String>{
    home,
    details,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.home, page: Home),
    RouteDef(Routes.details, page: Details),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    Home: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Home(),
        settings: data,
      );
    },
    Details: (data) {
      final args = data.getArgs<DetailsArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => Details(
          args.coordinates,
          args.address,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// Details arguments holder class
class DetailsArguments {
  final List<Location> coordinates;
  final List<Placemark> address;
  DetailsArguments({@required this.coordinates, @required this.address});
}
