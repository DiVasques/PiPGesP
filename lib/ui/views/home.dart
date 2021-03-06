import 'package:flutter/material.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';
import 'package:pipgesp/ui/controllers/home_controller.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';
import 'package:pipgesp/ui/utils/app_colors.dart';
import 'package:pipgesp/ui/widgets/gadget_tile.dart';
import 'package:pipgesp/ui/widgets/home_drawer.dart';
import 'package:pipgesp/ui/utils/dimensions.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final String? email;
  final GlobalKey _scaffoldkey = GlobalKey();
  Home({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => HomeController(email: email!),
      child: Consumer<HomeController>(
        builder: (context, homeController, _) {
          return Scaffold(
            key: _scaffoldkey,
            floatingActionButton: FloatingActionButton(
              backgroundColor: theme.primaryColor,
              tooltip: "Adicionar Dispositivo",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  GenericRouter.addGadgetRoute,
                  arguments: homeController.user,
                );
              },
              elevation: 0,
              child: Icon(
                Icons.add,
              ),
            ),
            drawer: HomeDrawer(),
            appBar: AppBar(
              iconTheme: IconThemeData(color: theme.primaryColor),
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                "PiPGesP",
                style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
            backgroundColor: Colors.white,
            body: () {
              switch (homeController.state) {
                case ViewState.busy:
                  return Center(
                    child: SizedBox(
                      height: Dimensions.screenHeight(context) * 0.04,
                      width: Dimensions.screenHeight(context) * 0.04,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                case ViewState.error:
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error',
                          style: TextStyle(
                            color: AppColors.defaultGrey,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          homeController.errorMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.defaultGrey,
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.replay_outlined,
                            size: 30,
                          ),
                          onPressed: () => homeController.getUser(),
                          color: AppColors.defaultGrey,
                        ),
                      ],
                    ),
                  );
                case ViewState.idle:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "IP:",
                                style: TextStyle(
                                  color: AppColors.darkText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "${homeController.user.raspberryIP}",
                                style: TextStyle(
                                  color: AppColors.darkText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: () {
                          if (homeController.user.gadgets.isEmpty) {
                            return Center(
                              child: Text(
                                'Nenhum Dispositivo Cadastrado',
                                style: TextStyle(
                                    color: theme.primaryColorDark,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          } else {
                            Future<void> _onRefresh() async {
                              return await homeController.getUser();
                            }

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dispositivos Cadastrados',
                                        style: TextStyle(
                                            color: AppColors.darkText,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Divider(
                                        thickness: .5,
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: RefreshIndicator(
                                    onRefresh: _onRefresh,
                                    child: ListView(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      children: () {
                                        List<GadgetTile> widgets = [];
                                        for (Gadget gadget
                                            in homeController.user.gadgets) {
                                          widgets.add(GadgetTile(
                                            gadget: gadget,
                                            raspberryIP:
                                                homeController.user.raspberryIP,
                                            identifier:
                                                homeController.user.email,
                                            scaffoldContext:
                                                _scaffoldkey.currentContext ??
                                                    context,
                                          ));
                                        }
                                        return widgets;
                                      }(),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }(),
                      )
                    ],
                  );
              }
            }(),
          );
        },
      ),
    );
  }
}
