import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class Arm extends StatefulWidget {
  const Arm({Key? key}) : super(key: key);

  @override
  State<Arm> createState() => _ArmState();
}

class _ArmState extends State<Arm> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> workArr = [
      {"name": "Dips", "image": "assets/img/arnold-dips.webp", "url": "https://www.youtube.com/shorts/8Wqw9vjfvzY"},
      {"name": "Hummer", "image": "assets/img/hummer.png", "url": "https://www.youtube.com/watch?v=OPqe0kCxmR8"},
      {"name": "Incline dumbbell curl", "image": "assets/img/incline.png", "url": "https://www.youtube.com/watch?v=aTYlqC_JacQ"},
      {"name": "Over head dp exercise", "image": "assets/img/head.webp", "url": "https://www.youtube.com/shorts/kuBA3SXTNp4"},
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
