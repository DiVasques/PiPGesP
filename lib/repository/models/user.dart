import 'package:pipgesp/repository/models/gadget.dart';

class User {
  String uid;
  String name;
  String email;
  String registration;
  int? raspPort;
  late List<Gadget> gadgets = [];
  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.registration,
    this.raspPort,
  });
}
