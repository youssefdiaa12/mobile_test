import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../model/trainer.dart';
import '../viewModel/app_provider.dart';

class AddTrainerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Trainer', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AddTrainerForm(),
        ),
      ),
    );
  }
}

class AddTrainerForm extends StatefulWidget {
  @override
  _AddTrainerFormState createState() => _AddTrainerFormState();

}

class _AddTrainerFormState extends State<AddTrainerForm> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String job = '';
  File? file;
  int? age;
  String? phoneNumber;
  String? otherJob;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      file = File(result.files.single.path!);
      setState(() {});
    }
  }
@override
Widget build(BuildContext context) {
  var provider = Provider.of<AppProvider>(context);
  return Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
          onSaved: (value) {
            name = value!;
          },
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          value: job.isNotEmpty ? job : null,
          hint: const Text('Select Job'),
          onChanged: (newValue) {
            setState(() {
              job = newValue!;
            });
          },
          items: ['gym', 'fitness', 'other']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Colors.black)),
            );
          }).toList(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        if (job == 'other') ...[
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Other Job',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your job';
              }
              return null;
            },
            onSaved: (value) {
              otherJob = value!;
            },
          ),
        ],
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Age',
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter an age';
            }
            return null;
          },
          onSaved: (value) {
            age = int.parse(value!);
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a phone number';
            }
            return null;
          },
          onSaved: (value) {
            phoneNumber = value!;
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  var status = await Permission.storage.status;
                  if (!status.isGranted) {
                    await Permission.storage.request();
                  }
                  await _pickPDF();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.pink),
                ),
                child: const Text(
                    'Pick PDF', style: TextStyle(color: Colors.black)),
              ),
            ),
            if (file != null)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'PDF Selected',
                  style: TextStyle(color: Colors.green),
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Trainer newTrainer = Trainer(
                      name,
                      job,
                      age.toString(),
                      "1",
                      phoneNumber,
                      file!.path,
                    );
                    await provider.add_trainer(newTrainer, file!);
                    Navigator.pop(context);
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.pink),
                ),
                child: const Text(
                    'Add Trainer', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}}
