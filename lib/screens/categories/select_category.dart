import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serviceprovider/const.dart';
import 'package:get/get.dart';
import 'package:serviceprovider/global.dart';
import 'package:serviceprovider/screens/authentication/logIn_screen.dart';
import '../categories/detials_screen.dart';

class SelectCategory extends StatefulWidget {
  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  static const values = <String>[
    'Event Planner',
    'Resturant',
    'Venue',
    'Photographer',
    'Decorator',
    'Transport',
    'Catering',
    'Beauty Saloon',
    'Bakeries'
  ];
  String? data;

  String selectedvalue = values.first;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "select Category",
            style: TextStyle(color: kblackColor),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              fauth.signOut();
              Get.to(LogIn());
            },
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(DetailsScreen(
                  data == null ? "Event Planner" : data,
                ));
                print(data);
              },
              icon: Icon(
                Icons.arrow_forward,
                size: 25.w,
                color: kblackColor,
              ),
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          children: [
            buildRadios(),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRadios() => Column(
        children: values.map(
          (value) {
            return RadioListTile<String>(
              value: value,
              groupValue: selectedvalue,
              title: Text(value),
              onChanged: (value) {
                setState(() {
                  data = selectedvalue = value as String;
                });
              },
            );
          },
        ).toList(),
      );
}
