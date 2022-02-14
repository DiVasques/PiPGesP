import 'package:flutter/material.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';
import 'package:pipgesp/ui/utils/app_colors.dart';
import 'package:pipgesp/ui/widgets/gadget_icon.dart';
import 'package:pipgesp/utils/string_capitalize.dart';

class GadgetTile extends StatelessWidget {
  final Gadget gadget;
  const GadgetTile({Key? key, required this.gadget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, GenericRouter.gadgetRoute,
            arguments: gadget),
        child: Padding(
          padding: const EdgeInsets.all(8.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                    style: TextStyle(
                      color: AppColors.darkText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              GadgetIcon(type: gadget.type),
            ],
          ),
        ),
      ),
    );
  }
}