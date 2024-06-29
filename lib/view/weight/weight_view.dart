import 'package:flutter/material.dart';

class CalorieCalculator extends StatefulWidget {
  const CalorieCalculator({Key? key}) : super(key: key);

  @override
  _CalorieCalculatorState createState() => _CalorieCalculatorState();
}

class _CalorieCalculatorState extends State<CalorieCalculator> {
  late double weight = 0.0;
  late double height = 0.0;
  late int age = 0;
  late String gender = 'Male';
  late double bmr = 0.0;
  late double bmi = 0.0;
  late String bmiResult = '';

  void calculateBMR() {
    if (gender == 'Male') {
      bmr = 66 + (13.75 * weight) + (5 * height) - (6.75 * age);
    } else {
      bmr = 655 + (9.56 * weight) + (1.85 * height) - (4.68 * age);
    }
    double heightInMeters = height / 100; // تحويل الطول إلى متر
    bmi = weight / (heightInMeters * heightInMeters); // حساب BMI
    if (bmi < 18.5) {
      bmiResult = 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      bmiResult = 'Normal weight';
    } else if (bmi >= 24.9 && bmi < 29.9) {
      bmiResult = 'Overweight';
    } else {
      bmiResult = 'Obese';
    }
    setState(() {}); // تحديث الواجهة بعد حساب قيمة BMI
  }

  Color _getBmiColor() {
    if (bmi < 18.5) {
      return Colors.blue; // اللون الأزرق لحالة الوزن غير الصحيح
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return Colors.green; // اللون الأخضر لحالة الوزن الصحيح
    } else if (bmi >= 24.9 && bmi < 29.9) {
      return Colors.orange; // اللون البرتقالي لحالة الوزن الزائد
    } else {
      return Colors.red; // اللون الأحمر لحالة البدانة
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie & BMI Calculator'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              height: MediaQuery.of(context).size.width * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: CircularProgressIndicator(
                      value: bmi / 50,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(_getBmiColor()),
                      strokeWidth: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  Center(
                    child: Text(
                      bmi.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.1,
                        fontWeight: FontWeight.bold,
                        color: _getBmiColor(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Text(
              'BMI: ${bmi.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[200],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Weight (kg)'),
                      onChanged: (value) {
                        setState(() {
                          weight = double.tryParse(value) ?? 0.0;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[200],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Height (cm)'),
                      onChanged: (value) {
                        setState(() {
                          height = double.tryParse(value) ?? 0.0;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[200],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Age'),
                      onChanged: (value) {
                        setState(() {
                          age = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            DropdownButtonFormField<String>(
              value: gender,
              items: ['Male', 'Female']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                calculateBMR();
              },
              child: Text('Calculate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(MediaQuery.of(context).size.width, 50.0),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'BMI Result: $bmiResult',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            // عرض السعرات الحرارية
            Text(
              'Calories: ${bmr.toStringAsFixed(2)} kcal',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CalorieCalculator(),
  ));
}
