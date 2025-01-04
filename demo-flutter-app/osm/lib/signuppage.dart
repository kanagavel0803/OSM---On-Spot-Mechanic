import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:osm/loginpage.dart';
import 'package:osm/mech_duty.dart';
import 'package:osm/user_form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final shopNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  String? selectedRole;

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void signUpUser() async {
    if (selectedRole == null) {
      showToast('Please select a role');
      return;
    }

    if (selectedRole == 'Mechanic' && (shopNameController.text.isEmpty || phoneNumberController.text.isEmpty)) {
      showToast('Please fill all mechanic details');
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
      showToast('Sign up successful');

      if (selectedRole == 'User') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VehicleForm()),
        );
      } else if (selectedRole == 'Mechanic') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MechDutyPage()),
        );
      }
    } catch (error) {
      Navigator.pop(context);
      showToast(error.toString().split("]").elementAt(1).trim());
    }
  }

  void signUpWithGoogle() {
    showToast('Sign up with Google Built-In Process');
    // Implement Google sign-up logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blueGrey, width: 2.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset("images/logo_clr.png", width: MediaQuery.of(context).size.width * 0.5),
                const SizedBox(height: 20),
                Text(
                  "Begin Your Journey With Us!!",
                  style: GoogleFonts.notoSans(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 25),
                buildTextField(usernameController, 'Email Address'),
                const SizedBox(height: 10),
                buildTextField(passwordController, 'Password', obscureText: true),
                const SizedBox(height: 10),
                buildDropdown(),
                if (selectedRole == 'Mechanic') ...[
                  const SizedBox(height: 10),
                  buildTextField(shopNameController, 'Shop Name'),
                  const SizedBox(height: 10),
                  buildTextField(phoneNumberController, 'Phone Number', keyboardType: TextInputType.phone),
                ],
                const SizedBox(height: 10),
                buildLoginText(),
                const SizedBox(height: 20),
                buildSignUpButton(),
                const SizedBox(height: 20),
                
                // Divider with "Or Continue With"
                Row(
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
                
                const SizedBox(height: 30),
                
                // Google Sign-Up Button
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                    label: Text(
                      'Sign Up With Google',
                      style: GoogleFonts.notoSans(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A8BDF),
                      minimumSize: const Size(250, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      side: const BorderSide(color: Colors.blueGrey),
                    ),
                    onPressed: signUpWithGoogle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hintText, {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFEFFAFD),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: DropdownButtonFormField<String>(
        value: selectedRole,
        items: const [
          DropdownMenuItem(value: 'User', child: Text('User')),
          DropdownMenuItem(value: 'Mechanic', child: Text('Mechanic')),
        ],
        onChanged: (value) {
          setState(() {
            selectedRole = value;
          });
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFEFFAFD),
          hintText: 'Select Role',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  Widget buildLoginText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: const Text("Log In Instead", style: TextStyle(color: Color(0xFF4A8BDF))),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const LoginPage(),
                  transitionDuration: const Duration(milliseconds: 0),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildSignUpButton() {
    return ElevatedButton(
      onPressed: signUpUser,
      child: Text("Sign Up", style: GoogleFonts.notoSans(color: Colors.black)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4A8BDF),
        minimumSize: const Size(250, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        side: const BorderSide(color: Colors.blueGrey),
      ),
    );
  }
}
