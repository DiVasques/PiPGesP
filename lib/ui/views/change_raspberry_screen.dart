import 'package:flutter/material.dart';
import 'package:pipgesp/repository/models/user.dart';
import 'package:pipgesp/ui/controllers/base_controller.dart';
import 'package:pipgesp/ui/controllers/change_raspberry_controller.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';
import 'package:pipgesp/ui/utils/app_colors.dart';
import 'package:pipgesp/ui/utils/dimensions.dart';
import 'package:pipgesp/ui/utils/validators.dart';
import 'package:pipgesp/ui/widgets/default_text_field.dart';
import 'package:provider/provider.dart';

class ChangeRaspberryScreen extends StatefulWidget {
  final User user;
  const ChangeRaspberryScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ChangeRaspberryScreenState createState() => _ChangeRaspberryScreenState();
}

class _ChangeRaspberryScreenState extends State<ChangeRaspberryScreen> {
  static const TextStyle style = TextStyle(fontSize: 15);
  late FocusNode _raspberryIPFocus;

  @override
  void initState() {
    _raspberryIPFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _raspberryIPFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => ChangeRaspberryController(user: widget.user),
      child: Consumer<ChangeRaspberryController>(
        builder: (context, changeRaspberryController, _) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: theme.primaryColor),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.white,
            body: () {
              switch (changeRaspberryController.state) {
                case ViewState.idle:
                  return Column(
                    children: [
                      Expanded(
                        child: Form(
                          key: changeRaspberryController.formKey,
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            children: [
                              Text(
                                'Mudar Raspberry',
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
                                  labelText: 'IP do Raspberry',
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  initValue: changeRaspberryController
                                      .user.raspberryIP,
                                  validator: FieldValidators.validateIP,
                                  onSaved: (value) => changeRaspberryController
                                      .raspberryIP = value,
                                  focusNode: _raspberryIPFocus,
                                  style: style,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).unfocus();
                                    triggerAndHandleChangeRaspberry(
                                        changeRaspberryController);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          triggerAndHandleChangeRaspberry(
                              changeRaspberryController);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Mudar',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.edit,
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

  void triggerAndHandleChangeRaspberry(
      ChangeRaspberryController changeRaspberryController) {
    changeRaspberryController.changeRaspberry().then((bool? result) {
      if (result != null) {
        if (result) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            GenericRouter.homeRoute,
            (route) => false,
            arguments: changeRaspberryController.user.email,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
              content: Text('Erro. Tente novamente mais tarde'),
            ),
          );
        }
      }
    });
  }
}
