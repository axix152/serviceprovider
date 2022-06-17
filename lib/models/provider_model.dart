import 'package:firebase_database/firebase_database.dart';

class ProviderModel {
  String? id;
  String? name;
  String? email;
  String? phone;

  ProviderModel({
    this.id,
    this.name,
    this.email,
    this.phone,
  });

  ProviderModel.fromJson(DataSnapshot snapshot) {
    id = snapshot.key;
    name = (snapshot.value as dynamic)["name"];
    email = (snapshot.value as dynamic)["email"];
    phone = (snapshot.value as dynamic)["phone"];
  }
}
