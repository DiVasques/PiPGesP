import 'package:flutter/material.dart';
import 'package:pipgesp/services/authentication_services.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';
import 'package:pipgesp/ui/controllers/home_controller.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<HomeController>(
      builder: (context, homeController, _) {
        return homeController.state == ViewState.busy
            ? Center(
                child: CircularProgressIndicator(
                    backgroundColor: theme.primaryColor),
              )
            : Drawer(
                child: SafeArea(
                  child: homeController.state == ViewState.error
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ListTile(
                              title: Text("Recarregar"),
                              trailing: Icon(Icons.replay_outlined),
                              onTap: () {
                                homeController.getUser();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text("Sair"),
                              tileColor: Colors.red[200],
                              trailing: Icon(Icons.exit_to_app),
                              onTap: () {
                                AuthenticationServices.userLogout();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  GenericRouter.loginRoute,
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ListTile(
                              title: Text("Recarregar"),
                              trailing: Icon(Icons.replay_outlined),
                              onTap: () {
                                homeController.getUser();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text("Sair"),
                              tileColor: Colors.red[200],
                              trailing: Icon(Icons.exit_to_app),
                              onTap: () {
                                AuthenticationServices.userLogout();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  GenericRouter.loginRoute,
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          ],
                        ),
                ),
              );
      },
    );
  }
}
