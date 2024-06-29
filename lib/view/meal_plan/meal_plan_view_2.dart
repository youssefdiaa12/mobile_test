import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Fitness_Community/view/meal_plan/dinner.dart';
import 'package:Fitness_Community/view/meal_plan/lunck.dart';
import 'package:Fitness_Community/view/meal_plan/snack.dart';
import 'package:Fitness_Community/view/workout/workout_detail_view.dart';

import '../../common/color_extension.dart';
import '../../common_widget/tab_button.dart';
import 'BreakFastList.dart';

class MealPlanView2 extends StatefulWidget {
  const MealPlanView2({super.key});

  @override
  State<MealPlanView2> createState() => _MealPlanView2State();
}

class _MealPlanView2State extends State<MealPlanView2> {
  int isActiveTab = 0;
  static List workArr = [
    {  
      "name": "Breafast",
      "title":"vegetable, Sandwich",
      "image": "assets/img/break fast.jpg"
   },
    { 
      "name": "Snack",
      "title": "Boat, nut, butter",
      "image": "assets/img/snacks.jpg"
    },
    {
      "name": "lunch",
      "title": "vegetable, Sandwich",
      "image": "assets/img/lanch.jpg",
    },
    {
      "name": "Dinner",
       "title": "Boat, nut, butter",
      "image": "assets/img/Dinner.jpg",
    },
  ];
  static List waterArr = [
    {"name": "Evian", "title":"Natural Spring Water",
      "image": "https://m.media-amazon.com/images/I/61zyd4fi9SL.jpg"},
    {"name": "Fiji", "title": "Artesian Water", "image": "https://m.media-amazon.com/images/I/71-NOTjvM+L._SL1500_.jpg"},
    {
      "name": "Perrier",
      "title": "Sparkling Natural Mineral Water",
      "image": "https://m.media-amazon.com/images/I/718j3xLTfVL._SL1500_.jpg",
    },
    {
      "name": "San Pellegrino",
      "title": "Sparkling Natural Mineral Water",
      "image": "https://m.media-amazon.com/images/I/71Wp4QepnQL._SL1500_.jpg",
    },
  ];
  DateTime date=DateTime.now();
  //format date

  List<String> days=["Mon","Tue","Wed","Thu","Fri","Sat","Sun"];
  List<String> months=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
  final List<Widget> _widgetOptions = <Widget>[
    Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          itemCount: waterArr.length,
          itemBuilder: (context, index) {
            var wObj = waterArr[index] as Map? ?? {};
            print(wObj["image"]);
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: TColor.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  InkWell(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const BreakfastList()));
                          break;
                        case 1:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Snack()));
                          break;
                        case 2:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Lunch()));
                        case 3:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Dinner()));
                          break;
                      }
                    },

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:CachedNetworkImage(
                        imageUrl: wObj["image"],
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          width: double.infinity,
                          height: 300,
                          margin: const EdgeInsets.all(10),
                        ),
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.error);
                        },
                        imageBuilder: (context, imageProvider) => Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),


                  Text(
                    wObj["name"],
                    style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),

                  Text(
                    wObj["title"],
                    style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14),
                  ),

                ],
              ),
            );
          }),
    ),
    Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          itemCount: workArr.length,
          itemBuilder: (context, index) {
            var wObj = workArr[index] as Map? ?? {};
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: TColor.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  InkWell(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const BreakfastList()));
                          break;
                        case 1:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Snack()));
                          break;
                        case 2:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Lunch()));
                        case 3:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Dinner()));
                          break;
                      }
                    },

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        wObj["image"].toString(),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),


                  Text(
                    wObj["name"],
                    style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),

                  Text(
                    wObj["title"],
                    style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14),
                  ),

                ],
              ),
            );
          }),
    ),


  ];

  @override
  Widget build(BuildContext context) {
    //get day now
    String day_now=days[date.weekday-1];
    //get month now
    String month_now=months[date.month-1];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.primary,
        centerTitle: true,
        elevation: 0,
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
          "Meal Plan",
          style: TextStyle(
              color: TColor.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(children: [
        Container(
          decoration: BoxDecoration(color: TColor.white, boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
          ]),
          child: Row(
            children: [
              Expanded(
               
                child: TabButton2(
                  title: "Water",
                  isActive: isActiveTab == 0,
                  onPressed: () {
                    setState(() {
                      isActiveTab = 0;
                    });
                  },
                ),
              ),
              Expanded(
                
                child: TabButton2(
                  title: "Food",
                  isActive: isActiveTab == 1,
                  onPressed: () {
                    setState(() {
                      isActiveTab = 1;
                    });
                  },
                ),
              ),
             
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/img/black_fo.png",
                  width: 20,
                  height: 20,
                ),
              ),
              Expanded(
                child: Text("$day_now ${date.day} $month_now ${date.year}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/img/next_go.png",
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
        _widgetOptions.elementAt(isActiveTab),

      ]),
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
