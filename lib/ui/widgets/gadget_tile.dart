import 'package:flutter/material.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/ui/controllers/home_controller.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';
import 'package:pipgesp/ui/utils/app_colors.dart';
import 'package:pipgesp/ui/utils/gadget_types.dart';
import 'package:pipgesp/ui/widgets/gadget_icon.dart';
import 'package:pipgesp/utils/string_capitalize.dart';
import 'package:provider/provider.dart';

class GadgetTile extends StatelessWidget {
  final Gadget gadget;
  final String identifier;
  final String raspberryIP;
  final BuildContext scaffoldContext;
  const GadgetTile(
      {Key? key,
      required this.gadget,
      required this.identifier,
      required this.raspberryIP,
      required this.scaffoldContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, GenericRouter.gadgetRoute,
            arguments: {
              "raspberryIP": raspberryIP,
              "gadget": gadget,
              "identifier": identifier
            }),
        child: Padding(
          padding: const EdgeInsets.all(8.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GadgetIcon(device: gadget.device),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 1.5,
                    height: 45,
                    color: Theme.of(context).dividerColor,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${gadget.name.toTitleCase()}",
                        style: TextStyle(
                          color: AppColors.darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Porta ${gadget.physicalPort} (${gadget.iotype.translatedValue()})",
                        style: TextStyle(
                          color: AppColors.darkText,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Consumer<HomeController>(builder: (context, homeController, _) {
                return IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    homeController
                        .deleteGadget(raspberryIP, gadget)
                        .then((result) {
                      if (!result) {
                        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 2),
                            content: Text('Erro. Tente novamente mais tarde'),
                          ),
                        );
                      }
                    });
                  },
                  iconSize: 24,
                  color: AppColors.lightRed,
                  icon: Icon(Icons.delete),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
