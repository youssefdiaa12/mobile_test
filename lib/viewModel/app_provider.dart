import 'dart:io';

import 'package:flutter/material.dart';

import '../model/trainer.dart';
import '../model/trainerDao.dart';

class AppProvider extends ChangeNotifier {
  Future<void>add_trainer(Trainer trainer,File pdf)async {

    await UserDao().createuser(trainer,pdf);

  }

}
