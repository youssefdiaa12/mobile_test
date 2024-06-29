import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class Foot extends StatefulWidget {
  const Foot({Key? key}) : super(key: key);

  @override
  State<Foot> createState() => _FootState();
}

class _FootState extends State<Foot> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> workArr = [
      {"name": "5 DOT DRILLS", "image": "assets/img/5-Dot-drills-agility-exercise.gif", "url": "https://www.youtube.com/watch?v=IODxDxX7oi4"},
      {"name": "HIGH KNEE LUNGE ON BOSU BALL", "image": "assets/img/High-Knee-Lunge-on-Bosu-Ball.gif", "url": "https://www.youtube.com/shorts/RjmYBmMBmOM"},
      {"name": "STANDING LEG CIRCLES", "image": "assets/img/Standing-Leg-Circles (1).gif", "url": "https://www.youtube.com/watch?v=7j-2w4-P14I"},
      {"name": "STATIC LUNGE", "image": "assets/img/Static-Lunge - Copy.gif", "url": "https://www.youtube.com/watch?v=eMTy3qylqnE"},
      {"name": "DUMBBELL WALKING LUNGE", "image": "assets/img/dumbbell-lunges.gif", "url": "https://www.youtube.com/watch?v=eMTy3qylqnE"},
      {"name": "DUMBBELL GOOD MORNING", "image": "assets/img/Dumbbell-Good-Morning (1).gif", "url": "https://www.youtube.com/watch?v=eMTy3qylqnE"},
      {"name": "DUMBBELL SQUAT", "image": "assets/img/Dumbbell-Squat.gif", "url": "https://www.youtube.com/watch?v=eMTy3qylqnE"},
      {"name": "DEPTH JUMP TO HURDLE HOP", "image": "assets/img/Depth-Jump-to-Hurdle-Hop.gif", "url": "https://www.youtube.com/watch?v=eMTy3qylqnE"},
      {"name": "POWER LUNGE", "image": "assets/img/power-lunge.gif", "url": "https://www.youtube.com/watch?v=eMTy3qylqnE"},
      {"name": "DUMBBELL DEADLIFT", "image": "assets/img/dumbbell-deadlifts.gif", "url": "https://www.youtube.com/watch?v=eMTy3qylqnE"},
 
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
                height: MediaQuery.of(context).size.height * 0.50,
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
