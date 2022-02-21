import 'package:flutter/material.dart';
import 'package:pipgesp/ui/utils/app_colors.dart';
import 'package:pipgesp/ui/utils/gadget_devices.dart';

class GadgetIcon extends StatelessWidget {
  final GadgetDevice device;
  final double? size;
  final Color? color;
  const GadgetIcon({Key? key, required this.device, this.size = 30, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      () {
        switch (device) {
          case GadgetDevice.lamp:
            return Icons.lightbulb;
          case GadgetDevice.thermometer:
            return Icons.thermostat;
          case GadgetDevice.other:
            return Icons.power_settings_new_rounded;
          default:
        }
      }(),
      color: color ?? AppColors.defaultGrey,
      size: size,
    );
  }
}
