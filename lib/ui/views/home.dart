import 'package:flutter/material.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';
import 'package:pipgesp/ui/controllers/home_controller.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';
import 'package:pipgesp/ui/widgets/home_drawer.dart';
import 'package:pipgesp/ui/utils/dimensions.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final String? email;
  const Home({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => HomeController(email: email!),
      child: Consumer<HomeController>(
        builder: (context, homeController, _) {
          return Scaffold(
            drawer: HomeDrawer(),
            appBar: AppBar(
              iconTheme: IconThemeData(color: theme.primaryColor),
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                "PiPGesP",
                style: TextStyle(color: theme.primaryColor),
              ),
            ),
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
                              'Bem-vindo, ${homeController.user.name}',
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
