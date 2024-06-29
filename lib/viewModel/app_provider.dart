import 'dart:io';

import 'package:Fitness_Community/model/user_dao.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/trainer.dart';
import '../model/trainerDao.dart';
import '../model/user.dart';

class AppProvider extends ChangeNotifier {
  bool is_visible = true;

  // This is an optional UserLocal object to store the current user
  UserLocal? user;

  // This is an optional integer to store the number of watch lists
  int? number_watch_list;

  // This is an optional SharedPreferences instance for local storage
  SharedPreferences? prefs;

  // This boolean indicates whether the user is authenticated
  bool is_auth = false;

  // Asynchronously saves user information to local storage
  Future<void> saveuser(UserLocal user) async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setString('id', user.id!);
    prefs?.setString('name', user.name!);
    prefs?.setString('email', user.email!);
    prefs?.setString('photo', user.photo ?? '');
  }
  Future<void> updateuser(UserLocal user) async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setString('id', user.id!);
    prefs?.setString('name', user.name!);
    prefs?.setString('email', user.email!);
    prefs?.setString('photo', user.photo ?? '');
    prefs?.setString('role', user.role??'');
  }
  Future<void> update_user_image(File image) async {
    UserDao userDao = UserDao();
    String image_path = await userDao.upload_User_image(image,user!.id!);
    user!.photo = image_path;
    await updateuser(user!);
    notifyListeners();
  }

  Future<List<Trainer>> getTrainer() async {
    TrainerDao trainerDao = TrainerDao();
    return await trainerDao.getalltrainer();
  }

  Future<void> deletetrainer(String id) async {
    TrainerDao trainerDao = TrainerDao();
    await trainerDao.Deletetrainer(id);
  }
  // Notifies listeners of state changes
  void notify() {
    notifyListeners();
  }

  // Asynchronously deletes user information from local storage
  Future<void> deleteuser() async {
    prefs = await SharedPreferences.getInstance();
    prefs?.remove('id');
    prefs?.remove('name');
    prefs?.remove('email');
    prefs?.remove('photo');
    user = null;
    is_auth = false;
    notifyListeners();
  }

  // Asynchronously retrieves user information from local storage
  Future<void> getuser() async {
    prefs = await SharedPreferences.getInstance();
    String? id = prefs?.getString('id');
    String? name = prefs?.getString('name');
    String? email = prefs?.getString('email');
    String? photo = prefs?.getString('photo');
    String role = prefs?.getString('role') ?? '';
    if (photo == '') {
      photo = null;
    }

    // If user ID is found, create a new UserLocal object and set is_auth to true
    if (id != null) {
      user = UserLocal(name, email, id, photo, role);
      is_auth = true;
    }
    print("is_auth${is_auth}");
    notifyListeners();
  }

  Future<void> add_trainer(Trainer trainer, File pdf) async {
    await TrainerDao().createtrainer(trainer, pdf);
  }

  Future<void> login(String? id) async {
    UserDao userDao = UserDao();
    user = await userDao.getuser(id ?? '1');
    print(user?.name);
    print(user?.email);
    print(user?.id);
    await saveuser(user!);
    notifyListeners();
  }

  // Asynchronously signs up a new user
  Future<void> sign_up(UserLocal user1) async {
    UserDao userDao = UserDao();
    await userDao.createuser(user1);
    user = user1;
    await saveuser(user1);
    print(user?.email);
    print(user?.id);
    notifyListeners();
    return;
  }

  // Asynchronously logs out the current user
  Future<void> logout() async {
    user = null;
    await deleteuser();
    notifyListeners();
  }
}
