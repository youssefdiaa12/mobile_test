import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/color_extension.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  DateTime nowTime = DateTime.now();
  DateTime targetDate = DateTime.now();
  Map<DateTime, String> notes = {};

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notesData = prefs.getString('notes');
    if (notesData != null) {
      setState(() {
        notes = Map<DateTime, String>.from(
          json.decode(notesData).map(
            (key, value) => MapEntry(DateTime.parse(key), value),
          ),
        );
      });
    }
  }

  Future<void> _saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedNotes = notes.entries.map((entry) {
      return json.encode({
        'date': entry.key.toIso8601String(),
        'note': entry.value,
      });
    }).toList();
    await prefs.setStringList('notes', encodedNotes);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.primary,
        centerTitle: true,
        elevation: 0.1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Schedule",
          style: TextStyle(
            color: TColor.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.MMMM().format(targetDate).toUpperCase(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: TColor.secondaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          DateFormat.y().format(targetDate),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: TColor.secondaryText,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        targetDate = DateTime(targetDate.year, targetDate.month - 1);
                      });
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: TColor.secondaryText.withOpacity(0.7),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        targetDate = DateTime(targetDate.year, targetDate.month + 1);
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: TColor.secondaryText.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Stack(
                children: [
                  CalendarCarousel(
                    todayButtonColor: TColor.primary,
                    todayBorderColor: TColor.primary,
                    selectedDayButtonColor: TColor.primary,
                    selectedDayBorderColor: TColor.primary,
                    onDayPressed: (DateTime date, List events) {
                      _showNoteDialog(date);
                    },
                    onCalendarChanged: (date) {
                      setState(() {
                        targetDate = date;
                      });
                    },
                    selectedDayTextStyle: TextStyle(
                      color: TColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    daysTextStyle: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    weekDayFormat: WeekdayFormat.narrow,
                    weekdayTextStyle: TextStyle(
                      color: TColor.gray,
                      fontSize: 20,
                    ),
                    weekendTextStyle: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    thisMonthDayBorderColor: Colors.transparent,
                    showHeader: false,
                    customDayBuilder: (
                      bool isSelectable,
                      int index,
                      bool isSelectedDay,
                      bool isToday,
                      bool isPrevMonthDay,
                      TextStyle textStyle,
                      bool isNextMonthDay,
                      bool isThisMonthDay,
                      DateTime day,
                    ) {
                      var hasNote = notes.containsKey(day);
                      if (hasNote) {
                        return Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            day.day.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: TColor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      }
                    },
                    weekFormat: false,
                    height: 340.0,
                    selectedDateTime: nowTime,
                    targetDateTime: targetDate,
                    daysHaveCircularBorder: true,
                  ),
                  Positioned(
                    top: 33,
                    child: Divider(
                      color: Colors.black26,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(
                "Note",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              shrinkWrap: true,
              itemCount: notes.length,
              itemBuilder: (context, index) {
                var entry = notes.entries.elementAt(index);
                return Container(
                  padding: const EdgeInsets.only(bottom: 15, left: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          entry.key.day.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: TColor.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: TextStyle(
                            color: TColor.secondaryText,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showNoteDialog(DateTime selectedDate) async {
    TextEditingController _textController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Enter your note here...',
                  ),
                ),
             
                  ],
                ),
              ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                String note = _textController.text;
                if (note.isNotEmpty) {
                  setState(() {
                    notes[selectedDate] = note;
                  });
                  _saveNotes(); // Save notes when a new note is added
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}