import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:osm/loginpage.dart';
import 'package:osm/mech_duty.dart';
import 'package:osm/user_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String? selectedRole; // For dropdown value

  void wrongEmailMessage(String s) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(s),
          );
        });
  }

  void signUpUser() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
      Navigator.pop(context);

      // Navigate based on role
      if (selectedRole == 'Mechanic') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MechDutyPage())); 
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => VehicleForm()));
      }
    } catch (error) {
      Navigator.pop(context);
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
                const SizedBox(height: 80),
                const SizedBox(height: 40),
                const Image(image: AssetImage("images/logo_clr.png")),
                Text(
                  "Begin Your Journey With Us!!",
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
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
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: const InputDecoration(
                      hintText: 'Role',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'User',
                        child: Text('User'),
                      ),
                      DropdownMenuItem(
                        value: 'Mechanic',
                        child: Text('Mechanic'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Text(
                          "Sign In Instead",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const LoginPage(),
                                transitionDuration:
                                    const Duration(milliseconds: 0),
                              ));
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: signUpUser,
                  child: const Text("Sign Up"),
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Or Continue With",
                            style: TextStyle(color: Colors.grey[700]),
                          )),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                    child: Container(
                  width: 350,
                  height: 70,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200]),
                  child: Row(
                    children: [
                      const SizedBox(width: 60),
                      Image.asset(
                        "images/google_icon.png",
                        height: 30,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Sign In With Google",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
        ));
  }
}
