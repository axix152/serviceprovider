import 'package:firebase_database/firebase_database.dart';
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
  final _dbref = FirebaseDatabase.instance.ref().child("serviceProvider");
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
            StreamBuilder(
              stream: _dbref.onValue,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Failed to load data"),
                  );
                }
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  Map data1 = snapshot.data.snapshot.value;
                  List item = [];
                  // data1.forEach((index, snap) {
                  //   Map usermap = {};
                  //   usermap.addAll(snap['request']);

                  //   usermap.forEach((key, value) {
                  //     print(value['name']);
                  //     print(value['email']);
                  //   });
                  // });
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data1.length,
                      padding: EdgeInsets.all(7.h),
                      shrinkWrap: true,
                      itemBuilder: ((context, i) => Container(
                            margin: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.person,
                                size: 35.h,
                                color: Colors.black,
                              ),
                              title: Text(
                                "Aziz khan",
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text('aziz@gmail.com'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.close,
                                      size: 32.h,
                                    ),
                                    color: Colors.red.shade500,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.done,
                                      size: 32.h,
                                    ),
                                    color: Colors.green.shade500,
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  );
                }
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.pink.shade400,
                ));
              },
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
    required this.name,
    required this.email,
    required this.done,
    required this.close,
    Key? key,
  });
  final AssetImage image;
  final String name;
  final String email;
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
          name,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(email),
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
