import 'package:flutter/material.dart';
import 'package:pipgesp/ui/routers/generic_router.dart';

class Home extends StatelessWidget {
  //final String email;
  const Home({Key? key}) : super(key: key);

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '(Sanitarium',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Icon(
                  Icons.music_note_sharp,
                  color: Colors.black,
                  size: 13,
                ),
                Text(
                  ')',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ],
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
