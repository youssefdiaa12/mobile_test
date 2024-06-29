import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class Back extends StatefulWidget {
  const Back({Key? key}) : super(key: key);

  @override
  State<Back> createState() => _BackState();
}

class _BackState extends State<Back> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> workArr = [
      {"name": "ROWING MACHINE", "image": "assets/img/Rowing-Machine.gif", "url": "https://www.youtube.com/shorts/8Wqw9vjfvzY"},
      {"name": "LEVER FRONT PULLDOWN", "image": "assets/img/Front-Pulldown.gif", "url": "https://www.youtube.com/watch?v=OPqe0kCxmR8"},
      {"name": "PULL-UP", "image": "assets/img/Pull-up.gif", "url": "https://www.youtube.com/watch?v=aTYlqC_JacQ"},
      {"name": "INCLINE CHEST FLY MACHINE", "image": "assets/img/Incline-Chest-Fly-Machine.gif", "url": "https://www.youtube.com/shorts/kuBA3SXTNp4"},
      {"name": "CABLE REAR PULLDOWN", "image": "assets/img/Cable-Rear-Pulldown.gif", "url": "https://www.youtube.com/watch?v=OPqe0kCxmR8"},
      {"name": "LAT PULLDOWN", "image": "assets/img/Lat-Pulldown.gif", "url": "https://www.youtube.com/watch?v=OPqe0kCxmR8"},
      {"name": "SEATED CABLE ROW", "image": "assets/img/Seated-Cable-Row.gif", "url": "https://www.youtube.com/watch?v=OPqe0kCxmR8"},
      {"name": "BARBELL BENT OVER ROW", "image": "assets/img/Barbell-Bent-Over-Row.gif", "url": "https://www.youtube.com/watch?v=OPqe0kCxmR8"},
      {"name": "CABLE STRAIGHT ARM PULLDOWN", "image": "assets/img/Cable-Straight-Arm-Pulldown.gif", "url": "https://www.youtube.com/watch?v=OPqe0kCxmR8"},
      {"name": "LEVER T-BAR ROW", "image": "assets/img/Lever-T-bar-Row.gif", "url": "https://www.youtube.com/watch?v=OPqe0kCxmR8"},
    ];
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      _launchURL(workArr[index]["url"]);
                    },
                    label: 'Play',
                    foregroundColor: Colors.white,
                    icon: Icons.play_arrow,
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      //give it height
                      //       fit: BoxFit.cover,
                                           workArr[index]["image"],
                      height: MediaQuery.of(context).size.height*0.35,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                      
                        workArr[index]["name"],
                        style: const TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: workArr.length,
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
