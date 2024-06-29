import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
//import dialog utilities
import 'package:Fitness_Community/common/dialog_utils.dart';

import '../LoginScreen.dart';
import '../common/camera_class.dart';
import '../viewModel/app_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var  provider = Provider.of<AppProvider>(context);
    void logout() async {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              content: SingleChildScrollView(
                child: Row(
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      " Please wait...",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          });

      var obj = Provider.of<AppProvider>(context, listen: false);

      await obj.logout();

      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return  LoginScreen();
          },
        ),
            (_) => false,
      );
    }

    Future<void> ShowDialog() async {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          actions: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            var obj = Provider.of<AppProvider>(context, listen: false);
                            File? temp = await CameraClass.cameraPicker();
                            if (temp != null) {
                              setState(() {
                                Future.delayed(
                                  Duration.zero,
                                      () async {
                                    obj.update_user_image(temp);
                                      },
                                );
                                Navigator.pop(context);
                              });
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: const Icon(Icons.camera_enhance),
                        ),
                        const Text("Camera"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 60),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            var obj = Provider.of<AppProvider>(context, listen: false);
                            File? temp = await CameraClass.galleryPicker();
                            if (temp != null) {
                              setState(() {
                                Future.delayed(
                                  Duration.zero,
                                      () async {
                                    obj.update_user_image(temp);
                                  },
                                );
                                Navigator.pop(context);
                              });
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: const Icon(Icons.image),
                        ),
                        const Text("Gallery"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }    var obj = Provider.of<AppProvider>(context);
    File? image;
    if (obj.user?.photo == null) {
      image = null;
    } else if (obj.user?.photo?.isEmpty == false) {
      image = File(obj.user!.photo!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      backgroundImage: image == null ? null : Image.network(
                        obj.user!.photo!,
                        fit: BoxFit.cover,
                      ).image,

                      child: image == null
                          ? const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 70,
                      )
                          : null,
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () async {
                            await ShowDialog();
                            provider.notify();
                            setState(() {

                            });
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text(
                'User Email',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              subtitle: Text(
                obj.user?.email ?? '',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'User Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              subtitle: Text(
                obj.user?.name ?? '',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'User ID',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              subtitle: Text(
                obj.user?.id ?? '',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),

            const Divider(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  logout();
                },
                icon: const Icon(Icons.logout,
                    color: Colors.white, size: 20),
                label: const Text('Log out',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                        color: Colors.white
                    )),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
