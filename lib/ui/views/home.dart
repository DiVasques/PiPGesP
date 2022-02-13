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
  const Home({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => HomeController(email: email!),
      child: Consumer<HomeController>(
        builder: (context, homeController, _) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: theme.primaryColor,
              tooltip: "Adicionar Dispositivo",
              onPressed: () {},
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
            backgroundColor: homeController.state == ViewState.error
                ? Colors.red[400]
                : Colors.white,
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
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          homeController.errorMessage,
                          style: TextStyle(color: Colors.white, fontSize: 20),
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
                  );
                case ViewState.idle:
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
                    return ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      shrinkWrap: true,
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
                              //height: 30,
                            ),
                          ] +
                          () {
                            List<GadgetTile> widgets = [];
                            for (Gadget gadget in homeController.user.gadgets) {
                              widgets.add(GadgetTile(
                                gadget: gadget,
                              ));
                            }
                            return widgets;
                          }(),
                    );
                  }
              }
            }(),
          );
        },
      ),
    );
  }
}
