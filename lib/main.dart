import 'package:Fitness_Community/viewModel/app_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Fitness_Community/LoginScreen.dart';
import 'package:Fitness_Community/firebase_options.dart';
import 'package:Fitness_Community/view/menu/menu_view.dart';
import 'package:provider/provider.dart';
import 'common/color_extension.dart';
import 'view/schedule/schedule_view.dart'; // استدعاء صفحة ScheduleView

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var provider =AppProvider();

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (buildContext) => provider),
        ],
        child: const MyApp(
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness community',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Quicksand",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black38),
        useMaterial3: false,
      ),
      home: LoginScreen(), // استخدام ScheduleView كصفحة رئيسية
    );
  }
}
