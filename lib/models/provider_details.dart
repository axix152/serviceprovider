import 'package:firebase_database/firebase_database.dart';

class ProviderDetails {
  String? description;
  String? location;
  String? title;
  String? price;
  String? url;

  ProviderDetails({
    this.description,
    this.location,
    this.title,
    this.price,
    this.url,
  });

  ProviderDetails.fromSnapshot(DataSnapshot snap) {
    description = (snap.value as dynamic)["Description"];
    location = (snap.value as dynamic)["Location"];
    title = (snap.value as dynamic)["Title"];
    price = (snap.value as dynamic)["Price"];
    url = (snap.value as dynamic)["Url"];
  }
}
