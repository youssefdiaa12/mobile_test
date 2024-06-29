import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class Bench extends StatefulWidget {
  const Bench({Key? key}) : super(key: key);

  @override
  State<Bench> createState() => _BenchState();
}

class _BenchState extends State<Bench> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> workArr = [
      {"name": "MEDICINE BALL OVERHEAD THROW", "image": "assets/img/Medicine-Ball-Overhead-Throw (1).gif", "url": "https://www.youtube.com/shorts/8Wqw9vjfvzY"},
      {"name": "STANDING MEDICINE BALL CHEST PASS", "image": "assets/img/Standing-Medicine-Ball-Chest-Pass.gif", "url": "https://www.youtube.com/watch?v=OPqe0kCxmR8"},
      {"name": "ARM SCISSORS", "image": "assets/img/Arm-Scissors.gif", "url": "https://www.youtube.com/watch?v=aTYlqC_JacQ"},
      {"name": "INCLINE CHEST FLY MACHINE", "image": "assets/img/Incline-Chest-Fly-Machine.gif", "url": "https://www.youtube.com/shorts/kuBA3SXTNp4"},
      {"name": "BENCH PRESS", "image": "assets/img/Barbell-Bench-Press.gif", "url": "https://www.youtube.com/shorts/kuBA3SXTNp4"},
      {"name": "PEC DECK FLY", "image": "assets/img/Pec-Deck-Fly.gif", "url": "https://www.youtube.com/shorts/kuBA3SXTNp4"},
      {"name": "DUMBBELL PULLOVER", "image": "assets/img/Dumbbell-Pullover.gif", "url": "https://www.youtube.com/shorts/kuBA3SXTNp4"},
      {"name": "LOW CABLE CROSSOVER", "image": "assets/img/Low-Cable-Crossover.gif", "url": "https://www.youtube.com/shorts/kuBA3SXTNp4"},
      {"name": "HIGH CABLE CROSSOVER", "image": "assets/img/High-Cable-Crossover.gif", "url": "https://www.youtube.com/shorts/kuBA3SXTNp4"},
      {"name": "CABLE UPPER CHEST CROSSOVERS", "image": "assets/img/Cable-Upper-Chest-Crossovers.gif", "url": "https://www.youtube.com/shorts/kuBA3SXTNp4"},

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
