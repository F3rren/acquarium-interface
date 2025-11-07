import 'package:acquariumfe/main.dart';
import 'package:acquariumfe/routes/routes_name.dart';
import 'package:acquariumfe/view/add_aquarium.dart';
import 'package:acquariumfe/view/aquarium_details.dart';
import 'package:acquariumfe/view/delete_aquarium.dart';
import 'package:acquariumfe/view/edit_aquarium.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.details:
        return MaterialPageRoute(builder: (_) => const AquariumDetails());
      
      case RouteNames.addAquarium:
        return MaterialPageRoute(builder: (_) => const AddAquarium());
      
      case RouteNames.editAquarium:
        return MaterialPageRoute(builder: (_) => const EditAquarium());
      
      case RouteNames.deleteAquarium:
        return MaterialPageRoute(builder: (_) => const DeleteAquarium());

      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}