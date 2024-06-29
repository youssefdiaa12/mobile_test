import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Fitness_Community/registration.dart';
import 'package:Fitness_Community/view/menu/menu_view.dart';
import 'package:Fitness_Community/common/dialog_utils.dart';
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 140.0,
        backgroundColor: Colors.black,
        title:  Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Image.asset('images/logo.png'),
        ),

      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                // Logo for Fitness Community
                const SizedBox(height: 40.0),
                // Email Input
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  controller: _emailController,
                  style: const TextStyle(
                    color: Colors.black, // لون الذهبي
                  ),
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
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),

                const SizedBox(height: 40.0),

                // Password Input
                 TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.black // لون الذهبي
                  ),
                  decoration: InputDecoration(
                    iconColor: Colors.white
                    ,prefixIconColor: Colors.white,
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
                    prefixIcon: const Icon(Icons.password, color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,

                  ),
                ),

                const SizedBox(height: 40.0),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )
                    ),
                    onPressed: () async{
                      dialogUtilites.lodingDialog(context, 'Logging in...');
                      String result = await Login();


                      if(result == 'Success'){
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MenuView()),
                        );
                      }
                      else{
                        Navigator.pop(context);
                        dialogUtilites.showmsg(context, "Something went wrong",
                        postAction: (){
                          Navigator.pop(context);
                        }
                        );
                      }
                      // Navigate to the home screen and replace the current screen
                    },
                    child: const Text('Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,

                      )),
                  ),
                ),

                const SizedBox(height: 20.0),

                // Clickable text for registration
                GestureDetector(
                  onTap: () {
                    // Navigate to the registration screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationScreen()),
                    );
                  },
                  child: const Text(
                    'New here? Register',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> Login() async {
    // Register user
    if(!_formKey.currentState!.validate()){
      return 'Please enter valid data';
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _emailController.text,
          password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return e.toString();
    } catch (e) {
      return e.toString();
    }
    return 'Success';
  }
}