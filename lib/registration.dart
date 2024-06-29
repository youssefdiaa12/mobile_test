// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Fitness_Community/common/dialog_utils.dart';
import 'package:Fitness_Community/view/menu/menu_view.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController FirstName = TextEditingController();
  TextEditingController LastName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController ConfirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black,
        title: Text('Registration',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,

        )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade300,

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Fitness Community',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,

                    )
                  ),
                  SizedBox(height: 40.0),
                  // Registration form fields
                  TextFormField(
                    controller: email,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                            style: BorderStyle.solid,

                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                            style: BorderStyle.solid,
                          )
                      ),
                      prefixIcon: const Icon(Icons.email, color: Colors.black38),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),

                  SizedBox(height: 40.0),

                  TextFormField(
                    controller: FirstName,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                            style: BorderStyle.solid,

                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                            style: BorderStyle.solid,
                          )
                      ),
                      prefixIcon: const Icon(Icons.person, color: Colors.black38),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),

                  SizedBox(height: 40.0),

                  TextFormField(
                    controller: LastName,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                            style: BorderStyle.solid,

                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                            style: BorderStyle.solid,
                          )
                      ),
                      prefixIcon: const Icon(Icons.person, color: Colors.black38),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),

                  SizedBox(height: 40.0),

                  TextFormField(
                    controller: password,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                            style: BorderStyle.solid,

                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                            style: BorderStyle.solid,
                          )
                      ),
                      prefixIcon: const Icon(Icons.password, color: Colors.black38),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),

                  SizedBox(height: 40.0),

                  TextFormField(
                    controller: ConfirmPassword,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please confirm your password';
                      }
                      else if(value != password.text){
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                            style: BorderStyle.solid,

                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                            style: BorderStyle.solid,
                          )
                      ),
                      prefixIcon: const Icon(Icons.password, color: Colors.black38),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),

                  SizedBox(height: 40.0),

                  // Registration Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                      ),
                      onPressed: () async{
                        dialogUtilites.showmsg(context, 'Registering...');
                        String result = await registerUser();
                        if(result == 'Success'){
                          dialogUtilites.showmsg(context, 'Registration Successful');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MenuView()),
                          );
                        }
                        else{
                          Navigator.pop(context);
                          dialogUtilites.showmsg(context, result,
                          postAction: (){
                            Navigator.pop(context);
                          });
                        }

                        // Add your registration logic here
                        print('Registration button pressed');
                      },
                      child: Text('Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                        )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<String> registerUser() async {
    // Register user
    if(!formKey.currentState!.validate()){
      return 'Please enter valid data';
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.toString();
    } catch (e) {
      return e.toString();
    }
    return 'Success';
  }

}