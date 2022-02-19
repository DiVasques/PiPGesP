import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';
import 'package:pipgesp/ui/controllers/gadget_controller.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';
import 'package:pipgesp/ui/utils/app_colors.dart';
import 'package:pipgesp/ui/utils/gadget_types.dart';
import 'package:pipgesp/ui/utils/utils.dart';
import 'package:pipgesp/ui/widgets/gadget_icon.dart';
import 'package:pipgesp/ui/utils/dimensions.dart';
import 'package:pipgesp/utils/string_capitalize.dart';
import 'package:provider/provider.dart';

class GadgetScreen extends StatelessWidget {
  final Gadget gadget;
  final String identifier;
  const GadgetScreen({Key? key, required this.gadget, required this.identifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => GadgetController(physicalPort: gadget.physicalPort),
      child: Consumer<GadgetController>(
        builder: (context, gadgetController, _) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: theme.primaryColor),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.white,
            body: () {
              switch (gadgetController.state) {
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
                          'Dado Indisponível no Momento',
                          style: TextStyle(
                              color: AppColors.defaultGrey, fontSize: 20),
                        ),
                        Text(
                          gadgetController.errorMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.defaultGrey, fontSize: 20),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.replay_outlined,
                            size: 30,
                          ),
                          onPressed: () => gadgetController.getGadgetData(),
                          color: AppColors.defaultGrey,
                        ),
                      ],
                    ),
                  );
                case ViewState.idle:
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${gadget.name.toTitleCase()}',
                              style: TextStyle(
                                color: AppColors.darkText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            IconButton(
                              onPressed: () {
                                gadgetController
                                    .deleteGadget(identifier, gadget)
                                    .then((bool result) {
                                  if (result) {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        GenericRouter.homeRoute,
                                        (route) => false,
                                        arguments: identifier);
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: AppColors.defaultGrey,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GadgetIcon(
                        device: gadget.device,
                        size: 80,
                        color: gadgetController.outputFormValue
                            ? theme.primaryColor
                            : null,
                      ),
                      SizedBox(height: 15),
                      () {
                        switch (gadget.iotype) {
                          case GadgetType.output:
                            return SwitchListTile(
                              title: Text('Ativar/Desativar'),
                              value: gadgetController.outputFormValue,
                              onChanged: (value) {
                                gadgetController.setGadgetOutput(value);
                              },
                            );
                          case GadgetType.input:
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Status'),
                                    Text(
                                        '${processGadgetStatusText(gadgetController.gadgetData.data as bool)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: (gadgetController
                                                  .gadgetData.data as bool)
                                              ? theme.primaryColor
                                              : Colors.red,
                                        )),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Última atualização'),
                                    Text(
                                        '${processLastChangedDate(gadgetController.gadgetData.lastChange)}',
                                        style: TextStyle(fontSize: 13)),
                                  ],
                                ),
                              ],
                            );
                          case GadgetType.spi:
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Temperatura'),
                                    Text(
                                        '${gadgetController.gadgetData.data.toString()}°C',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Última atualização'),
                                    Text(
                                        '${processLastChangedDate(gadgetController.gadgetData.lastChange)}',
                                        style: TextStyle(fontSize: 13)),
                                  ],
                                ),
                              ],
                            );
                        }
                      }()
                    ],
                  );
              }
            }(),
          );
        },
      ),
    );
  }

  String processLastChangedDate(DateTime lastChange) {
    if (lastChange.day == DateTime.now().day) {
      return DateFormat(Utils.timeFormat).format(lastChange);
    }
    return DateFormat(Utils.dateFormat).format(lastChange);
  }

  String processGadgetStatusText(bool status) {
    if (status) {
      return "Ligado";
    }
    return "Desligado";
  }
}
