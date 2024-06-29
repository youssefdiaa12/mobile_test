import 'package:flutter/material.dart';

import '../../common/color_extension.dart';
import '../../common_widget/tab_button.dart';
import 'Arm.dart';
import 'back.dart';
import 'bench.dart';
import 'foot.dart';

class ExerciseView2 extends StatefulWidget {
  const ExerciseView2({super.key});

  @override
  State<ExerciseView2> createState() => _ExerciseView2State();
}

class _ExerciseView2State extends State<ExerciseView2> {
  int isActiveTab = 0;
  List<Widget> workArr = [
    const Foot(),
    const Arm(),
    const Bench(),
    const Back(),
  ];

  @override
  Widget build(BuildContext context) {
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
          ),
        ),
        title: Text(
          "Exercise",
          style: TextStyle(
            color: TColor.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: TColor.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                for (int index = 0; index < 4; index++)
                  Expanded(
                    flex: isActiveTab == index ? 2 : 1,
                    child: TabButton2(
                      title: _getTabTitle(index),
                      isActive: isActiveTab == index,
                      onPressed: () {
                        setState(() {
                          isActiveTab = index;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: workArr[isActiveTab],
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Add your bottom navigation icons here
              // Example: InkWell(onTap: () {}, child: Icon(Icons.home)),
            ],
          ),
        ),
      ),
    );
  }

  String _getTabTitle(int index) {
    switch (index) {
      case 0:
        return "Legs";
      case 1:
        return "Arm";
      case 2:
        return "Bench";
      case 3:
        return "Back";
      default:
        return "";
    }
  }
}
