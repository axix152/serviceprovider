import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:serviceprovider/global.dart';
import 'package:serviceprovider/models/provider_details.dart';
import 'package:serviceprovider/models/provider_model.dart';

class AssistantModel {
  static void readCurrentUserInfo() async {
    currentFirebaseUser = fauth.currentUser;
    DatabaseReference usersRef = FirebaseDatabase.instance
        .ref()
        .child("serviceProvider")
        .child(currentFirebaseUser!.uid);

    usersRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        currentuserinfo = ProviderModel.fromJson(snap.snapshot);
        // ignore: prefer_interpolation_to_compose_strings, avoid_print
        print("Name " + currentuserinfo!.name.toString());
        // ignore: prefer_interpolation_to_compose_strings, avoid_print
        print("email " + currentuserinfo!.email.toString());
      } else {
        print("no data");
      }
    });
  }

  static void currentUserDetails() async {
    currentFirebaseUser = fauth.currentUser;
    DatabaseReference usersRef = FirebaseDatabase.instance
        .ref()
        .child("serviceProvider")
        .child(currentFirebaseUser!.uid)
        .child("details");
    usersRef.once().then((snap) {
      currentProviderDetails = ProviderDetails.fromSnapshot(snap.snapshot);

      // ignore: prefer_interpolation_to_compose_strings, avoid_print
      print("Title is " + currentProviderDetails!.title.toString());
    });
  }
}
