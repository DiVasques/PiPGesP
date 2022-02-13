import 'package:flutter/material.dart';
import 'package:pipgesp/ui/utils/app_colors.dart';
import 'package:pipgesp/ui/utils/gadget_types.dart';

class GadgetIcon extends StatelessWidget {
  final String type;
  const GadgetIcon({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      () {
        switch (type) {
          case GadgetType.lamp:
            return Icons.lightbulb;
          case GadgetType.temp:
            return Icons.thermostat;
          case GadgetType.decoupler:
            return Icons.camera_outlined;
          default:
        }
      }(),
      color: AppColors.defaultGrey,
      size: 30,
    );
  }
}
