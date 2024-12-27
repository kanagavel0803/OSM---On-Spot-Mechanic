import 'package:flutter/material.dart';
import 'mech_duty.dart';
import 'mech_account.dart';

class MechProfilePage extends StatefulWidget {
  @override
  _MechProfilePageState createState() => _MechProfilePageState();
}

class _MechProfilePageState extends State<MechProfilePage> {
  final TextEditingController mechanicNameController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController servicesController = TextEditingController();
  final TextEditingController workingDaysController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mech Profile'),
        backgroundColor: Color.fromARGB(255, 31, 157, 161),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color.fromARGB(255, 31, 157, 161),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              SizedBox(height: 30),
              Stack(
                children: [
                  buildTextField('Mechanic Name:', mechanicNameController),
                  Positioned(
                    right: 0,
                    top: -10,
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          isEditable = !isEditable;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              buildTextField('Shop Name:', shopNameController),
              SizedBox(height: 16),
              buildTextField('Services available:', servicesController),
              SizedBox(height: 16),
              buildTextField('Working days:', workingDaysController),
              SizedBox(height: 16),
              buildTextField('Phone Number:', phoneNumberController),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 200, 162, 146),
                    ),
                    onPressed: () {
                      // Handle save action
                      setState(() {
                        isEditable = false;
                      });
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 200, 162, 146),
                    ),
                    onPressed: () {
                      // Handle logout action
                    },
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 16, color: Colors.black),
                        SizedBox(width: 5),
                        Text(
                          'Logout',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        color: Color.fromARGB(255, 200, 162, 146),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MechDutyPage()),
                );
              },
              child: buildBottomIcon(Icons.build, 'Duty'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MechAccountPage()),
                );
              },
              child: buildBottomIcon(Icons.account_circle, 'Accounts'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MechProfilePage()),
                );
              },
              child: buildBottomIcon(Icons.person, 'Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Container(
          height: 35,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            enabled: isEditable,
          ),
        ),
      ],
    );
  }

  Widget buildBottomIcon(IconData iconData, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, size: 24),
        SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
