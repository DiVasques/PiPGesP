// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';
import 'package:pipgesp/ui/controllers/home_controller.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';
import 'package:pipgesp/utils/dimensions.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final String? email;
  const Home({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(email: email!),
      child: Consumer<HomeController>(
        builder: (context, homeController, _) {
          return Scaffold(
            backgroundColor: homeController.state == ViewState.error
                ? Colors.red[400]
                : Colors.white,
            body: Center(
              child: homeController.state == ViewState.busy
                  ? SizedBox(
                      height: Dimensions.screenHeight(context) * 0.04,
                      width: Dimensions.screenHeight(context) * 0.04,
                      child: const CircularProgressIndicator(),
                    )
                  : homeController.state == ViewState.idle
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome, ${homeController.user.name}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            Text(
                              '${homeController.user.email}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            Text(
                              '${homeController.user.registration}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 30,
                              ),
                              onPressed: () =>
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      GenericRouter.loginRoute,
                                      (route) => false),
                              color: Colors.black,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.replay_outlined,
                                size: 30,
                              ),
                              onPressed: () => homeController.getUser(),
                              color: Colors.black,
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Error',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              homeController.errorMessage,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.replay_outlined,
                                size: 30,
                              ),
                              onPressed: () => homeController.getUser(),
                              color: Colors.white,
                            ),
                          ],
                        ),
            ),
          );
        },
      ),
    );
  }
}
