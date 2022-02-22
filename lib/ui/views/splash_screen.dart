import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pipgesp/services/authentication_services.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      const Duration _duration = Duration(seconds: 3);
      Timer(_duration, () {
        String? email = AuthenticationServices.isUserAuthenticated();
        if (email == null) {
          Navigator.pushNamedAndRemoveUntil(context, GenericRouter.loginRoute,
              (Route<dynamic> route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, GenericRouter.homeRoute, (Route<dynamic> route) => false,
              arguments: email);
        }
      });
    });
    return Scaffold(
      body: Image.asset(
        "assets/images/splash.png",
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
      ),
    );
  }
}
