import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'user_form.dart';
import 'mech_duty.dart';
import 'signuppage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String? selectedRole;

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void signUserIn() async {
    if (selectedRole == null) {
      showToast('Please select a role');
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      Navigator.pop(context); // Close the loading dialog

      if (selectedRole == 'user') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VehicleForm()),
        );
      } else if (selectedRole == 'mechanic') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MechDutyPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close the loading dialog

      if (e.code == 'user-not-found') {
        showToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showToast('Invalid credentials.');
      } else {
        showToast('Error: ${e.message}');
      }
    } catch (error) {
      Navigator.pop(context); // Close the loading dialog
      showToast('Error: ${error.toString()}');
    }
  }

  void signInWithGoogle() {
    showToast('Sign up with Google Built-In Process');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: screenWidth * 0.9, // Make it responsive
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueGrey, width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.03),
                    Image.asset(
                      "images/logo_clr.png",
                      width: screenWidth * 0.5,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      controller: usernameController,
                      decoration: inputDecoration('Email Address'),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    TextFormField(
                      controller: passwordController,
                      decoration: inputDecoration('Password'),
                      obscureText: true,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      items: [
                        DropdownMenuItem(value: 'user', child: Text('User')),
                        DropdownMenuItem(value: 'mechanic', child: Text('Mechanic')),
                      ],
                      onChanged: (value) => setState(() => selectedRole = value),
                      decoration: inputDecoration('Select Role'),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Text(
                            "SignUp Instead",
                            style: TextStyle(color: const Color(0xFF4A8BDF)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const SignUpPage(),
                                transitionDuration: const Duration(milliseconds: 0),
                              ),
                            );
                          },
                        ),
                        Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ElevatedButton(
                      onPressed: signUserIn,
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.notoSans(color: Colors.black),
                      ),
                      style: buttonStyle(),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Row(
                      children: [
                        Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400])),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text("Or Continue With",
                              style: TextStyle(color: Color(0xFF9E9E9E))),
                        ),
                        Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400])),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    ElevatedButton.icon(
                      icon: const FaIcon(FontAwesomeIcons.google, color: Colors.white, size: 24),
                      label: Text('Sign In With Google', style: GoogleFonts.notoSans(color: Colors.black)),
                      style: buttonStyle(),
                      onPressed: signInWithGoogle,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFEFFAFD),
      hintText: hintText,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.blueGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
    );
  }

  ButtonStyle buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4A8BDF),
      minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
