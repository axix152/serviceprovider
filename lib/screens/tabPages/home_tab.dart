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
  final _dbref = FirebaseDatabase.instance
      .ref()
      .child("serviceProvider")
      .child(fauth.currentUser!.uid);
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
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Failed To load data"),
                  );
                }
                if (snapshot.hasData) {
                  List<Widget> item = [];
                  //print(snapshot.data.snapshot.value.toString());
                  final extractedData = snapshot.data.snapshot.value as Map;
                  //print(extractedData['request']);
                  if (extractedData['request'] != null) {
                    extractedData.forEach((index, snap) {
                      print(index);

                      if (index == 'request') {
                        Map requests = snap as Map;
                        requests.forEach((key, value) {
                          print("hello");
                          print(key.toString());
                          if (!(key == null)) {
                            var tile = ListTile(
                              leading: Icon(
                                Icons.person,
                                size: 35.h,
                                color: Colors.black,
                              ),
                              title: Text(
                                value['name'].toString(),
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(value['email'].toString()),
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
                            );
                            item.add(tile);
                          }
                        });
                      }
                    });
                  } else {
                    print("No data  ");
                  }

                  return Column(
                    children: item.isNotEmpty ? item : [],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
    );
  }
}

class Description extends StatefulWidget {
  const Description({
    Key? key,
    required this.title,
    required this.user,
  }) : super(key: key);

  final String title;
  final String user;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
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
            child: Description(
              title: title,
              user: user,
            ),
          ),
        ],
      ),
    );
  }
}
