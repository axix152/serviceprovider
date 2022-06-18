import 'package:firebase_auth/firebase_auth.dart';
import 'package:serviceprovider/models/provider_details.dart';
import 'package:serviceprovider/models/provider_model.dart';
import 'package:serviceprovider/models/request.dart';

final FirebaseAuth fauth = FirebaseAuth.instance;

User? currentFirebaseUser;

ProviderModel? currentuserinfo;
ProviderDetails? currentProviderDetails;
// Requests? userrequest;
