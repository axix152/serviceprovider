import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serviceprovider/global.dart';
import '../../widgets/myDrawer.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Service Provider"),
          centerTitle: true,
        ),
        drawer: MyDrawer(
          name: currentuserinfo!.name,
          email: currentuserinfo!.email,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomListItem(
              user: currentuserinfo!.name!,
              thumbnail: Container(
                height: 100.h,
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Image.network(
                  currentProviderDetails!.url!,
                  fit: BoxFit.fill,
                ),
              ),
              title: currentProviderDetails!.title!,
            ),
            Padding(
              padding: EdgeInsets.all(5.h),
              child: Text(
                "Requests",
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Request_widget(
              image: const AssetImage('assets/images/aziz.jpeg'),
              title: "Aziz khan",
              subtitle: "we need a Decoator",
              close: IconButton(
                onPressed: () {
                  print("close clicked");
                },
                icon: const Icon(Icons.close),
                color: Colors.red.shade700,
              ),
              done: IconButton(
                onPressed: () {
                  print("done clicked");
                },
                icon: const Icon(Icons.done),
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Request_widget extends StatelessWidget {
  const Request_widget({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.done,
    required this.close,
    Key? key,
  });
  final AssetImage image;
  final String title;
  final String subtitle;
  final IconButton close;
  final IconButton done;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.transparent,
          backgroundImage: image,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            close,
            done,
          ],
        ),
      ),
    );
  }
}

class _VideoDescription extends StatefulWidget {
  const _VideoDescription({
    Key? key,
    required this.title,
    required this.user,
  }) : super(key: key);

  final String title;
  final String user;

  @override
  State<_VideoDescription> createState() => _VideoDescriptionState();
}

class _VideoDescriptionState extends State<_VideoDescription> {
  var myrating = 3.5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17.0,
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Text(
            widget.user,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          SmoothStarRating(
            rating: myrating,
            size: 25,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            starCount: 5,
            color: Colors.yellow,
            borderColor: Colors.black,
            allowHalfRating: false,
            spacing: 2.0,
            onRatingChanged: (value) {
              setState(() {
                myrating = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.user,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: _VideoDescription(
              title: title,
              user: user,
            ),
          ),
        ],
      ),
    );
  }
}
