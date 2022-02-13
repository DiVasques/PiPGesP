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
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Recarregar"),
                                    Icon(
                                      Icons.replay_outlined,
                                      color: theme.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                homeController.getUser();
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: ListTile(
                                title: Text("Sair"),
                                trailing: Icon(
                                  Icons.exit_to_app,
                                  color: theme.primaryColor,
                                ),
                                onTap: () {
                                  AuthenticationServices.userLogout();
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    GenericRouter.loginRoute,
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            ListView(
                              shrinkWrap: true,
                              children: [
                                ConstrainedBox(
                                  constraints:
                                      BoxConstraints.tightFor(height: 50),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 20, bottom: 5),
                                    alignment: Alignment.bottomLeft,
                                    height: 300,
                                    child: Text(
                                      "Bem-vindo, ${homeController.user.name.split(" ")[0]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                ListTile(
                                  title: Text("Recarregar"),
                                  trailing: Icon(
                                    Icons.replay_outlined,
                                    color: theme.primaryColor,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    homeController.getUser();
                                  },
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: ListTile(
                                title: Text("Sair"),
                                trailing: Icon(
                                  Icons.exit_to_app,
                                  color: theme.primaryColor,
                                ),
                                onTap: () {
                                  AuthenticationServices.userLogout();
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    GenericRouter.loginRoute,
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                ),
              );
      },
    );
  }
}
