import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../viewModel/app_provider.dart';

class Trainerslist extends StatefulWidget {
  static const routeName = '/trainerslist';
  const Trainerslist({super.key});

  @override
  State<Trainerslist> createState() => _TrainerslistState();
}


class _TrainerslistState extends State<Trainerslist> {
  Future<void> _openPDF(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return FutureBuilder(
      future: provider.getTrainer(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Trainers List'),
              backgroundColor: Colors.black,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          var trainer = snapshot.data![index];
                          return Slidable(
                            key: ValueKey(trainer.id),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(onDismissed: () async {
                                if (provider.user!.role == "admin") {
                                  await provider.deletetrainer(trainer.id!);
                                  setState(() {});
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Permission Denied'),
                                        content: const Text('Only admins can delete trainers.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    if (provider.user!.role == "admin") {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Delete Trainer'),
                                            content: const Text('Are you sure you want to delete this trainer?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await provider.deletetrainer(trainer.id!);
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: const Text('Delete'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Permission Denied'),
                                            content: const Text('Only admins can delete trainers.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  label: 'Delete',
                                  backgroundColor: Colors.red,
                                ),
                              ],
                            ),
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      trainer.name ?? '',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(trainer.job ?? '', style: const TextStyle(fontSize: 16)),
                                    const SizedBox(height: 8),
                                    Text(trainer.phoneNumber ?? '', style: const TextStyle(fontSize: 16, color: Colors.black)),
                                    const SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                                        onPressed: () {
                                          if (trainer.pdf != null) {
                                            _openPDF(trainer.pdf!);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

