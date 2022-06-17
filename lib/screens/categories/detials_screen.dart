import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:serviceprovider/global.dart';
import 'package:serviceprovider/screens/splashScreen/splash_Screeen.dart';
import 'package:serviceprovider/widgets/circal_button_login_signup.dart';
import '../../const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/progress_dialog.dart';

class DetailsScreen extends StatefulWidget {
  final String? category;
  DetailsScreen([this.category]);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleCont = TextEditingController();
    TextEditingController descCont = TextEditingController();
    TextEditingController priceCont = TextEditingController();
    TextEditingController locationCont = TextEditingController();
    FirebaseFirestore.instance.collection('Categories');
    FirebaseStorage fs = FirebaseStorage.instance;
    Future<void> addDetails() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return const ProgressDialog(message: "Processing,Please wait...");
        },
      );
      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage!.path);
      try {
        await fs
            .ref()
            .child(widget.category!)
            .child(titleCont.text)
            .child(fileName)
            .putFile(imageFile)
            .then((p0) => print("Image Added"));
        url = await fs
            .ref()
            .child(widget.category!)
            .child(titleCont.text)
            .child(fileName)
            .getDownloadURL();
        print("Aziz here is your url $url");
      } on FirebaseException catch (error) {
        return print("error");
      }

      Map<String, dynamic> addDetails = {
        'Title': titleCont.text.trim(),
        'Description': descCont.text.trim(),
        'Price': priceCont.text.trim(),
        'Location': locationCont.text.trim(),
        'Url': url,
      };
      DatabaseReference usersRef =
          FirebaseDatabase.instance.ref().child("serviceProvider");
      usersRef.child(currentFirebaseUser!.uid).child("details").set(addDetails);
      Fluttertoast.showToast(msg: "Details has been saved.");
      Get.to(SplashScreen());
    }

    validateForm() {
      if (titleCont.text.isEmpty) {
        Fluttertoast.showToast(msg: "Title is required");
      } else if (descCont.text.isEmpty) {
        Fluttertoast.showToast(msg: "Description is required");
      } else if (priceCont.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter the price");
      } else if (locationCont.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter your location");
      } else {
        addDetails();
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Enter Details",
            style: TextStyle(color: kblackColor),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(7.h),
                height: 260.h,
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black26)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 50.w,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Click and upload Image",
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.pink.shade300,
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (builder) => bottomSheet(),
                        );
                      },
                      child: Text(
                        "Upload",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pickedImage != null
                  ? Container(
                      margin: EdgeInsets.all(9.h),
                      height: 120.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.h),
                      ),
                      child: Stack(children: [
                        Image.file(File(pickedImage!.path)),
                        Positioned(
                            left: 43.w,
                            top: -10.h,
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 25.w,
                              ),
                              onPressed: () {},
                            )),
                      ]),
                    )
                  : Container(),
              Details_TextField(
                titleCont: titleCont,
                maxline: 1,
                hintText: "Enter Title",
                icon: const Icon(Icons.title_outlined),
              ),
              Details_TextField(
                titleCont: descCont,
                maxline: 4,
                hintText: "Enter Description",
                icon: const Icon(Icons.description_outlined),
              ),
              Details_TextField(
                titleCont: priceCont,
                maxline: 1,
                hintText: "Enter Price",
                icon: const Icon(Icons.price_change_outlined),
              ),
              Details_TextField(
                titleCont: locationCont,
                maxline: 1,
                hintText: "Enter Location",
                icon: const Icon(Icons.location_city_outlined),
              ),
              Padding(
                padding: EdgeInsets.all(15.h),
                child: Center(
                  child: circal_button_login_signup(
                    onpressed: () async {
                      validateForm();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MainScreen(),
                      //   ),
                      // );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  XFile? pickedImage;
  String? url;
  Future<void> pickCamera() async {
    try {
      final picker = ImagePicker();
      var image = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        pickedImage = image;
      });
    } catch (err) {
      return print("error");
    }
  }

  Future<void> pickGallery() async {
    try {
      final picker = ImagePicker();
      var image = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        pickedImage = image;
      });
    } catch (exeption) {
      return print("error");
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Choose photo",
            style: TextStyle(
              color: kblackColor,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  pickCamera();
                },
                icon: const Icon(Icons.camera),
                label: const Text(
                  "Camera",
                  style: TextStyle(color: kblackColor),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              TextButton.icon(
                onPressed: () {
                  pickGallery();
                },
                icon: const Icon(Icons.image),
                label: const Text(
                  "Gallery",
                  style: TextStyle(color: kblackColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Details_TextField extends StatelessWidget {
  const Details_TextField({
    required this.titleCont,
    required this.hintText,
    required this.icon,
    required this.maxline,
  });

  final TextEditingController titleCont;
  final String hintText;
  final Icon icon;
  final int maxline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 7.h,
        left: 10.w,
        right: 10.w,
        bottom: 7.h,
      ),
      child: TextFormField(
        controller: titleCont,
        maxLines: maxline,
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: kblackColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
        ),
      ),
    );
  }
}
