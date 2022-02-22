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
            ? Container()
            : Drawer(
                child: SafeArea(
                  child: homeController.state == ViewState.error
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 20, bottom: 5),
                                        alignment: Alignment.bottomLeft,
                                        height: 50,
                                        child: Text(
                                          "Erro ao carregar os dados",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: theme.primaryColor,
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
                                ],
                              ),
                            ),
                            ListTile(
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
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 20, bottom: 5),
                                        alignment: Alignment.bottomLeft,
                                        height: 50,
                                        child: Text(
                                          "Bem-vindo, ${homeController.user.name.split(" ")[0]}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: theme.primaryColor,
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
                                      ListTile(
                                        title: Text("Trocar IP"),
                                        trailing: Icon(
                                          Icons.edit,
                                          color: theme.primaryColor,
                                        ),
                                        onTap: () {
                                          Navigator.popAndPushNamed(
                                            context,
                                            GenericRouter.changeRaspberryRoute,
                                            arguments: homeController.user,
                                          );
                                        },
                                      ),
                                      ListTile(
                                        title: Text("Limpar Dispositivos"),
                                        trailing: Icon(
                                          Icons.delete,
                                          color: theme.primaryColor,
                                        ),
                                        onTap: () {
                                          homeController
                                              .deleteAllGadgets()
                                              .then((bool? result) {
                                            Navigator.pop(
                                              context,
                                            );
                                            if (result != null) {
                                              if (!result) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    duration:
                                                        Duration(seconds: 2),
                                                    content: Text(
                                                        'Erro. Tente novamente mais tarde'),
                                                  ),
                                                );
                                              }
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
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
                          ],
                        ),
                ),
              );
      },
    );
  }
}
