import 'package:auto_route/auto_route_annotations.dart';
import 'details.dart';
import 'home.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: Home),
    MaterialRoute(page: Details),
  ],
)
class $Router {}
