import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PiPGesP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: MaterialColor(
          0xFF1F5F02,
          {
            50: const Color(0xFF1F5F02).withOpacity(.1),
            100: const Color(0xFF1F5F02).withOpacity(.2),
            200: const Color(0xFF1F5F02).withOpacity(.3),
            300: const Color(0xFF1F5F02).withOpacity(.3),
            400: const Color(0xFF1F5F02).withOpacity(.4),
            500: const Color(0xFF1F5F02).withOpacity(.5),
            600: const Color(0xFF1F5F02).withOpacity(.6),
            700: const Color(0xFF1F5F02).withOpacity(.7),
            800: const Color(0xFF1F5F02).withOpacity(.8),
            900: const Color(0xFF1F5F02).withOpacity(.9)
          },
        ),
      ),
      onGenerateRoute: GenericRouter.generateRoute,
      initialRoute: GenericRouter.splashRoute,
    );
  }
}
