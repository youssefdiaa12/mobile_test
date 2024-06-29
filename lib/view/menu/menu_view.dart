import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Fitness_Community/view/Payment.dart';
import 'package:Fitness_Community/view/home/home_view.dart';
import 'package:Fitness_Community/view/market.dart';
import 'package:Fitness_Community/view/meal_plan/meal_plan_view.dart';
import 'package:Fitness_Community/view/menu/yoga_view.dart';
import 'package:Fitness_Community/view/news.dart';
import 'package:Fitness_Community/view/settings.dart';
import 'package:Fitness_Community/view/trainer.dart';
import 'package:provider/provider.dart';
import '../../common/color_extension.dart';
import '../../common_widget/menu_cell.dart';
import '../../common_widget/plan_row.dart';
import '../../viewModel/app_provider.dart';
import '../exercise/exercise_view.dart';
import '../exercise/exercise_view_2.dart';
import '../meal_plan/meal_plan_view_2.dart';
import '../running/running_view.dart';
import '../schedule/schedule_view.dart';
import '../weight/weight_view.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  // Define colors
  Color appBarColor = Colors.black87;
  Color textColor = Colors.white;
  Color cardColor = const Color.fromARGB(255, 68, 62, 78);
  Color iconColor = Colors.white;

  var gridCrossAxisCount = 3; // Number of items in the grid
  var gridCrossAxisSpacing = 15.0; // Horizontal spacing between grid items
  var gridMainAxisSpacing = 15.0; // Vertical spacing between grid items

  var flexibleSpaceHeightPercentage = 0.6; // Flexible space height as percentage of screen height

  var menuCellImageSizePercentage = 0.12; // Image size inside menu cell as percentage of screen width

  List menuArr = [
    {"name": "Home", "image": "assets/img/home.png", "tag": "1"},
    {"name": "Calories", "image": "assets/img/caloires.png", "tag": "2"},
    {"name": "Market", "image": "assets/img/market.png", "tag": "3"},
    {"name": "Trainers", "image": "assets/img/Trainers.png", "tag": "4"},
    {"name": "Meal Plan", "image": "assets/img/meals.png", "tag": "5"},
    {"name": "Schedule", "image": "assets/img/Schedule.png", "tag": "6"},
    {"name": "Running", "image": "assets/img/running.png", "tag": "7"},
    {"name": "Exercises", "image": "assets/img/exercise.png", "tag": "8"},
    {"name": "News", "image": "assets/img/news.png", "tag": "9"},
    {"name": "Yoga", "image": "assets/img/yoga.png", "tag": "10"},
    {"name": "Payment", "image": "assets/img/visa.png", "tag": "11"},
    {"name": "Settings", "image": "assets/img/Settings icon.png", "tag": "12"},
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var aspectRatio = media.width / media.height;
    var gridChildAspectRatio = aspectRatio > 1.5 ? 1.5 : 0.75; // Adjust based on aspect ratio
var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: appBarColor,
                expandedHeight: media.width * flexibleSpaceHeightPercentage,
                collapsedHeight: kToolbarHeight + 20,
                flexibleSpace: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image.asset("assets/img/1.png", width: media.width, height: media.width * 0.8, fit: BoxFit.cover),
                    Container(
                      width: media.width,
                      height: media.height * 0.5,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                      child: Row(
                        children: [
                          provider.user?.photo == null?
                          Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(27),
                            ),
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Icon(Icons.person, color: textColor, size: 30),
                            ),
                          ):
                          Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(27),
                            ),
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(provider.user!.photo!, width: 50, height: 50, fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(provider.user!.name??'', style: TextStyle(fontSize: 20, color: textColor, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 4),
                                Text("Profile", style: TextStyle(fontSize: 15, color: textColor, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ];
          },
          body: GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCrossAxisCount,
              crossAxisSpacing: gridCrossAxisSpacing,
              mainAxisSpacing: gridMainAxisSpacing,
              childAspectRatio: gridChildAspectRatio,
            ),
            itemCount: menuArr.length,
            itemBuilder: (context, index) {
              var mObj = menuArr[index] as Map? ?? {};
              return MenuCell(
                mObj: mObj,
                onPressed: () {
                  switch (mObj["tag"].toString()) {
                    case "12":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                      break;
                    case "1":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                      );
                      break;
                    case "2":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalorieCalculator(),
                        ),
                      );
                      break;
                    case "3":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MarketPage1(),
                        ),
                      );
                      break;
                    case "4":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTrainerScreen(),
                        ),
                      );
                      break;
                    case "5":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MealPlanView2(),
                        ),
                      );
                      break;
                    case "6":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScheduleView(),
                        ),
                      );
                      break;
                    case "7":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RunningView(),
                        ),
                      );
                      break;
                    case "8":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExerciseView2(),
                        ),
                      );
                      break;
                    case "9":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsScreen(),
                        ),
                      );
                      break;
                    case "10":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const YogaView(),
                        ),
                      );
                      break;
                    case "11":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VisaPaymentPage(),
                        ),
                      );
                      break;
                    default:
                  }
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: cardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(mObj["image"] as String, width: media.width * menuCellImageSizePercentage, height: media.width * menuCellImageSizePercentage),
                      const SizedBox(height: 8),
                      Text(mObj["name"] as String, style: TextStyle(fontSize: 12, color: textColor)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
