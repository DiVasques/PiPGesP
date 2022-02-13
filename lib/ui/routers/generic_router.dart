import 'package:flutter/material.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/ui/views/home.dart';
import 'package:pipgesp/ui/views/login_screen.dart';
import 'package:pipgesp/ui/views/gadget_screen.dart';
import 'package:pipgesp/ui/views/splash_screen.dart';

class GenericRouter {
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String splashRoute = '/splash';
  static const String gadgetRoute = '/gadget';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case homeRoute:
        builder = (BuildContext _) => Home(email: settings.arguments as String);
        break;
      case loginRoute:
        builder = (BuildContext _) => const LoginScreen();
        break;
      case splashRoute:
        builder = (BuildContext _) => const SplashScreen();
        break;
      case gadgetRoute:
        builder = (BuildContext _) => GadgetScreen(gadget: settings.arguments as Gadget);
        break;
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('BUG: Rota não definida para ${settings.name}'),
              ),
            );
          },
        );
    }
    return MaterialPageRoute(builder: builder, settings: settings);
  }
}
