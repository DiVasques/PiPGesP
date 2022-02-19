import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pipgesp/repository/models/gadget.dart';
import 'package:pipgesp/repository/models/user.dart';
import 'package:pipgesp/ui/controllers/add_gadget_controller.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';
import 'package:pipgesp/ui/controllers/gadget_controller.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';
import 'package:pipgesp/ui/utils/app_colors.dart';
import 'package:pipgesp/ui/utils/device_options.dart';
import 'package:pipgesp/ui/utils/gadget_devices.dart';
import 'package:pipgesp/ui/utils/gadget_types.dart';
import 'package:pipgesp/ui/utils/utils.dart';
import 'package:pipgesp/ui/utils/validators.dart';
import 'package:pipgesp/ui/widgets/gadget_icon.dart';
import 'package:pipgesp/ui/utils/dimensions.dart';
import 'package:pipgesp/ui/widgets/default_text_field.dart';
import 'package:provider/provider.dart';

class AddGadgetScreen extends StatefulWidget {
  final User user;
  const AddGadgetScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<AddGadgetScreen> createState() => _AddGadgetScreenState();
}

class _AddGadgetScreenState extends State<AddGadgetScreen> {
  late FocusNode _nameFocus;
  late FocusNode _iotypeFocus;
  late FocusNode _deviceFocus;
  late FocusNode _physicalPortFocus;
  static const TextStyle style = TextStyle(fontSize: 15);

  @override
  void initState() {
    _nameFocus = FocusNode();
    _iotypeFocus = FocusNode();
    _deviceFocus = FocusNode();
    _physicalPortFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _iotypeFocus.dispose();
    _deviceFocus.dispose();
    _physicalPortFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => AddGadgetController(user: widget.user),
      child: Consumer<AddGadgetController>(
        builder: (context, addGadgetController, _) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: theme.primaryColor),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.white,
            body: () {
              switch (addGadgetController.state) {
                case ViewState.busy:
                  return Center(
                    child: SizedBox(
                      height: Dimensions.screenHeight(context) * 0.04,
                      width: Dimensions.screenHeight(context) * 0.04,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                case ViewState.idle:
                  return Column(
                    children: [
                      Expanded(
                        child: Form(
                          key: addGadgetController.formKey,
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            children: [
                              Text(
                                'Adicionar Dispositivo',
                                style: TextStyle(
                                  color: AppColors.darkText,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Divider(
                                thickness: .5,
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: DefaultTextField(
                                  hintText: 'Nome do Dispositivo',
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  validator: FieldValidators.validateName,
                                  onSaved: (value) =>
                                      addGadgetController.name = value,
                                  focusNode: _nameFocus,
                                  style: style,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_iotypeFocus);
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Tipo de IO',
                                      focusColor: theme.primaryColor,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      errorStyle:
                                          const TextStyle(fontSize: 11.0),
                                    ),
                                    validator: FieldValidators.validateNotEmpty,
                                    focusColor: theme.primaryColor,
                                    focusNode: _iotypeFocus,
                                    isDense: true,
                                    value: addGadgetController.gadgetType,
                                    onChanged: (value) {
                                      addGadgetController.gadgetType = value;
                                      addGadgetController.gadgetDevice = null;
                                      addGadgetController.physicalPort = null;
                                      FocusScope.of(context).unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_deviceFocus);
                                    },
                                    items: GadgetType.values
                                        .map<DropdownMenuItem<String>>(
                                            (GadgetType type) {
                                      return DropdownMenuItem<String>(
                                        value: type.name,
                                        child: Text(type.name),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      labelText: 'Tipo de Dispositivo',
                                      focusColor: theme.primaryColor,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      errorStyle:
                                          const TextStyle(fontSize: 11.0),
                                    ),
                                    validator: FieldValidators.validateNotEmpty,
                                    focusColor: theme.primaryColor,
                                    focusNode: _deviceFocus,
                                    isDense: true,
                                    hint: Text('Escolha um tipo'),
                                    value: addGadgetController.gadgetDevice,
                                    onChanged: (value) {
                                      addGadgetController.gadgetDevice = value;
                                      FocusScope.of(context).unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_physicalPortFocus);
                                    },
                                    items: () {
                                      switch (addGadgetController.gadgetType) {
                                        case 'input':
                                          return DeviceOptions.inputOptions
                                              .map<DropdownMenuItem<String>>(
                                                  (GadgetDevice device) {
                                            return DropdownMenuItem<String>(
                                              value: device.name,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(device.name),
                                                  GadgetIcon(
                                                    device: device,
                                                  )
                                                ],
                                              ),
                                            );
                                          }).toList();
                                        case 'output':
                                          return DeviceOptions.outputOptions
                                              .map<DropdownMenuItem<String>>(
                                                  (GadgetDevice device) {
                                            return DropdownMenuItem<String>(
                                              value: device.name,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(device.name),
                                                  GadgetIcon(
                                                    device: device,
                                                  )
                                                ],
                                              ),
                                            );
                                          }).toList();
                                        case 'spi':
                                          return DeviceOptions.spiOptions
                                              .map<DropdownMenuItem<String>>(
                                                  (GadgetDevice device) {
                                            return DropdownMenuItem<String>(
                                              value: device.name,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(device.name),
                                                  GadgetIcon(
                                                    device: device,
                                                  )
                                                ],
                                              ),
                                            );
                                          }).toList();
                                      }
                                    }(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Porta Física',
                                      focusColor: theme.primaryColor,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      errorStyle:
                                          const TextStyle(fontSize: 11.0),
                                    ),
                                    validator: FieldValidators.validateNotEmpty,
                                    focusColor: theme.primaryColor,
                                    focusNode: _physicalPortFocus,
                                    isDense: true,
                                    disabledHint:
                                        Text('Não há portas disponíveis'),
                                    hint: Text('Escolha uma porta'),
                                    value: addGadgetController.physicalPort,
                                    onChanged: (value) => addGadgetController
                                        .physicalPort = value,
                                    items: () {
                                      switch (addGadgetController.gadgetType) {
                                        case 'input':
                                        case 'output':
                                          return addGadgetController
                                              .availableIOPorts()
                                              .map<DropdownMenuItem<String>>(
                                                  (String port) {
                                            return DropdownMenuItem<String>(
                                              value: port,
                                              child: Text(port),
                                            );
                                          }).toList();
                                        case 'spi':
                                          return addGadgetController
                                              .availableSPIPorts()
                                              .map<DropdownMenuItem<String>>(
                                                  (String port) {
                                            return DropdownMenuItem<String>(
                                              value: port,
                                              child: Text(port),
                                            );
                                          }).toList();
                                      }
                                    }(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          addGadgetController.addGadget().then((bool? result) {
                            if (result != null) {
                              if (result) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  GenericRouter.homeRoute,
                                  (route) => false,
                                  arguments: addGadgetController.user.email,
                                );
                              }
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Adicionar',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.check,
                              color: theme.primaryColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                default:
                  return Center(
                    child: SizedBox(
                      height: Dimensions.screenHeight(context) * 0.04,
                      width: Dimensions.screenHeight(context) * 0.04,
                      child: const CircularProgressIndicator(),
                    ),
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
