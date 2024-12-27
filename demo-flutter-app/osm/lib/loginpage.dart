import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:osm/signuppage.dart'; // Make sure the path is correct
import 'google_map1.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void wrongEmailMessage(String s) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(s),
        );
      },
    );
  }

  void signUserIn() async {
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

    // Navigate to Google Map page upon successful login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => GoogleMapPage()),
    );
  } catch (error) {
    Navigator.pop(context); // Close the loading dialog
    wrongEmailMessage(error.toString().split("]").elementAt(1).trim());
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 80),
              const SizedBox(height: 40),
              Image(image: AssetImage("images/logo_clr.png")),
             
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Text(
                        "Sign Up Instead",
                        style: TextStyle(color: Color.fromARGB(147, 104, 103, 103)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const SignUpPage(),
                            transitionDuration: Duration(milliseconds: 0),
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
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: signUserIn,
                child: Text("Sign In"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Full-width button
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Or Continue With",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Container(
                  width: 350,
                  height: 70,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 60),
                        Image.asset(
                          "images/google_icon.png",
                          height: 30,
                        ),
                        Text(
                          "Sign In With Google",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
