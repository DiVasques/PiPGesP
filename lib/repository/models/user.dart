import 'package:pipgesp/repository/models/gadget.dart';

class User {
  String uid;
  String name;
  String email;
  String registration;
  String raspberryIP;
  late List<Gadget> gadgets = [];
  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.registration,
    required this.raspberryIP,
  });
}
