import 'package:flutter/material.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';
import 'package:pipgesp/ui/controllers/gadget_controller.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';
import 'package:pipgesp/ui/widgets/home_drawer.dart';
import 'package:pipgesp/ui/utils/dimensions.dart';
import 'package:pipgesp/utils/string_capitalize.dart';
import 'package:provider/provider.dart';

class GadgetScreen extends StatelessWidget {
  final Gadget gadget;
  const GadgetScreen({Key? key, required this.gadget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => GadgetController(id: gadget.id),
      child: Consumer<GadgetController>(
        builder: (context, gadgetController, _) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: theme.primaryColor),
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                "${gadget.name.toTitleCase()}",
                style: TextStyle(color: theme.primaryColor),
              ),
            ),
            backgroundColor: gadgetController.state == ViewState.error
                ? Colors.red[400]
                : Colors.white,
            body: Center(
              child: gadgetController.state == ViewState.busy
                  ? SizedBox(
                      height: Dimensions.screenHeight(context) * 0.04,
                      width: Dimensions.screenHeight(context) * 0.04,
                      child: const CircularProgressIndicator(),
                    )
                  : gadgetController.state == ViewState.idle
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Bem-vindo, ${gadgetController.id}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            Text(
                              "Porta ${() {
                                switch (gadget.physicalPort) {
                                  case 999:
                                    return 'serial';
                                  case 777:
                                    return 'USB';
                                  default:
                                    return gadget.physicalPort.toString();
                                }
                              }()}",
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
                              gadgetController.errorMessage,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.replay_outlined,
                                size: 30,
                              ),
                              onPressed: () => gadgetController.getGadgetData(),
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
