import 'package:flutter/material.dart';

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
  final TextEditingController noOfWorkersController = TextEditingController();

  bool isEditable = false;

  void saveProfileData() {
    String mechanicName = mechanicNameController.text;
    String shopName = shopNameController.text;
    String services = servicesController.text;
    String workingDays = workingDaysController.text;
    String phoneNumber = phoneNumberController.text;
    String noOfWorkers = noOfWorkersController.text;

    print("Saving data: $mechanicName, $shopName, $services, $workingDays, $phoneNumber, $noOfWorkers");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mech Profile'),
        backgroundColor: const Color(0xFF4A8BDF),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A8BDF),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        if (isEditable) {
                          saveProfileData();
                        }
                        isEditable = !isEditable;
                      });
                    },
                    child: Text(
                      isEditable ? 'Save' : 'Edit',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              buildTextField('Mechanic Name', mechanicNameController),
              SizedBox(height: 16),
              buildTextField('Shop Name', shopNameController),
              SizedBox(height: 16),
              buildTextField('Services Available', servicesController),
              SizedBox(height: 16),
              buildTextField('Working Days', workingDaysController),
              SizedBox(height: 16),
              buildTextField('Phone Number', phoneNumberController),
              SizedBox(height: 16),
              buildTextField('No Of Workers', noOfWorkersController),
            ],
          ),
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                offset: Offset(0, 3), // Shadow effect below input box
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade300, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade300, width: 1.5),
              ),
              focusedBorder : OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: const Color(0xFF4A8BDF), width: 2),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: TextStyle(fontSize: 14),
            enabled: isEditable,
          ),
        ),
      ],
    );
  }
}