import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../common/color_extension.dart';
import '../../common_widget/response_row.dart';

class YogaView extends StatefulWidget {
  const YogaView({super.key});

  @override
  State<YogaView> createState() => _YogaViewState();
}

class _YogaViewState extends State<YogaView> {
  List workArr = [
    {"name": "Running", "image": "assets/img/1.png"},
    {"name": "Jumping", "image": "assets/img/2.png"},
    {
      "name": "Running",
      "image": "assets/img/5.png",
    },
    {
      "name": "Jumping",
      "image": "assets/img/3.png",
    },
  ];

  List responseArr = [
    {
      "name": "Mikhail Eduardovich",
      "time": "09 days ago",
      "image": "assets/img/u2.png",
      "message": "Lorem ipsum dolor sit amet, conse ctetur adipiscing elit,"
    },
    {
      "name": "Mikhail Eduardovich",
      "time": "11 days ago",
      "image": "assets/img/u1.png",
      "message": "Lorem ipsum dolor sit amet, conse ctetur adipiscing elit,"
    },
    {
      "name": "Mikhail Eduardovich",
      "time": "12 days ago",
      "image": "assets/img/u2.png",
      "message": "Lorem ipsum dolor sit amet, conse ctetur adipiscing elit,"
    },
    {
      "name": "Mikhail Eduardovich",
      "time": "13 days ago",
      "image": "assets/img/u1.png",
      "message": "Lorem ipsum dolor sit amet, conse ctetur adipiscing elit,"
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.primary,
        centerTitle: true,
        elevation: 0.1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              "assets/img/black_white.png",
              width: 25,
              height: 25,
            )),
        title: Text(
          "Yoga",
          style: TextStyle(
              color: TColor.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
       
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/img/1.png",
              width: media.width,
              height: media.width * 0.55,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  IgnorePointer(
                    ignoring: true,
                    child: RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 25,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: TColor.primary,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/img/like.png",
                        width: 20,
                        height: 20,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/img/share.png",
                        width: 20,
                        height: 20,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(
                "Tips",
                style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),

             Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(
                '''
    1. **Consistency is Key:**
       - Establish a regular workout routine to build strength and endurance over time.
       - Aim for at least 3-4 sessions per week to see consistent progress.

    2. **Balanced Workouts:**
       - Include a mix of cardiovascular exercises, strength training, and flexibility exercises.
       - This approach helps improve overall fitness and prevents boredom.

    3. **Proper Warm-up and Cool Down:**
       - Always start with a proper warm-up to prepare your muscles and joints for exercise.
       - Finish your workout with a cool down to help your heart rate return to normal and reduce muscle soreness.

    4. **Set Realistic Goals:**
       - Establish achievable short-term and long-term fitness goals.
       - Regularly reassess and adjust your goals as you progress.

    5. **Proper Form is Crucial:**
       - Focus on maintaining proper form during exercises to prevent injuries.
       - Consider working with a fitness professional to ensure your technique is correct.

    6. **Stay Hydrated:**
       - Drink plenty of water before, during, and after your workout.
       - Proper hydration is essential for optimal performance and recovery.

    7. **Listen to Your Body:**
       - Pay attention to how your body responds to exercise.
       - Rest and recover when needed to avoid burnout and reduce the risk of overtraining.

    8. **Mix it Up:**
       - Keep your workouts interesting by trying new exercises or classes.
       - Variety not only keeps you engaged but also challenges different muscle groups.

    9. **Fuel Your Body:**
       - Eat a balanced diet with a mix of carbohydrates, proteins, and healthy fats to support your workouts.
       - Consider consulting with a nutritionist for personalized advice.

    10. **Get Adequate Rest:**
        - Allow your body time to recover and rebuild by getting enough sleep.
        - Lack of sleep can hinder your progress and increase the risk of injuries.

    Remember, everyone's fitness journey is unique. Listen to your body, stay committed, and enjoy the process of becoming a healthier and stronger version of yourself.
    ''',
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset("assets/img/menu_running.png",
                    width: 25, height: 25),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset("assets/img/menu_meal_plan.png",
                    width: 25, height: 25),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset("assets/img/menu_home.png",
                    width: 25, height: 25),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset("assets/img/menu_weight.png",
                    width: 25, height: 25),
              ),
              InkWell(
                onTap: () {},
                child:
                    Image.asset("assets/img/more.png", width: 25, height: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
