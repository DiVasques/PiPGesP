// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';

class Home extends StatelessWidget {
  final String? email;
  const Home({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome Home',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            Text(
              '$email',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, GenericRouter.loginRoute, (route) => false),
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
