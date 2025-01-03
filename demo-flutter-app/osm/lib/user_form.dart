// VehicleForm.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'google_map1.dart'; // Import the GoogleMapPage

class VehicleForm extends StatefulWidget {
  @override
  _VehicleFormState createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final vehicleRegController = TextEditingController();
  final vehicleModelController = TextEditingController();
  final vehicleColorController = TextEditingController();
  String? selectedVehicleType;
  String? selectedTransmissionType;
  bool isLoading = false; // Loading state

  final List<Map<String, String>> _colorSuggestions = [
    {'name': 'Red', 'hex': '#FF0000'},
    {'name': 'Blue', 'hex': '#0000FF'},
    {'name': 'Green', 'hex': '#008000'},
    {'name': 'Yellow', 'hex': '#FFFF00'},
    {'name': 'Black', 'hex': '#000000'},
    {'name': 'White', 'hex': '#FFFFFF'},
    {'name': 'Silver', 'hex': '#C0C0C0'},
    {'name': 'Gray', 'hex': '#808080'},
    {'name': 'Orange', 'hex': '#FFA500'},
    {'name': 'Brown', 'hex': '#A52A2A'},
    {'name': 'Purple', 'hex': '#800080'},
    {'name': 'Pink', 'hex': '#FFC0CB'},
    {'name': 'Cyan', 'hex': '#00FFFF'},
    {'name': 'Magenta', 'hex': '#FF00FF'},
  ];

  @override
  void dispose() {
    usernameController.dispose();
    vehicleRegController.dispose();
    vehicleModelController.dispose();
    vehicleColorController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Start loading
      });

      final username = usernameController.text;
      final vehicleRegNo = vehicleRegController.text;
      final vehicleType = selectedVehicleType;
      final vehicleModel = vehicleModelController.text;
      final vehicleColor = vehicleColorController.text;
      final transmissionType = selectedTransmissionType;

      try {
        await FirebaseFirestore.instance.collection('vehicles').add({
          'username': username,
          'vehicle_registration_number': vehicleRegNo,
          'vehicle_type': vehicleType,
          'vehicle_model': vehicleModel,
          'vehicle_color': vehicleColor,
          'transmission_type': transmissionType,
        });

        _showPermissionPopup(context);
      } catch (e) {
        print("Error saving vehicle data: $e");
      } finally {
        setState(() {
          isLoading = false; // Stop loading
        });
      }
    }
  }

  void _showPermissionPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Allow this "Maps" to access your location?',
            style: TextStyle(color: Color(0xFF4A8BDF), fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Your current location will be displayed on the map and used to locate nearby "Mechanic Garages".',
            style: TextStyle(color: Color.fromARGB(255, 30, 58, 61)),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Don't Allow", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(" Allow", style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoogleMapPage()),
                );
              },
            ),
          ],
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Form', style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF4A8BDF),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFE3F2FD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Welcome back, User!',
                  style: GoogleFonts.lato(
                    fontSize: isLargeScreen ? 35.0 : 32.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 30, 58, 61),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Enter your vehicle details',
                  style: GoogleFonts.lato(
                    fontSize: isLargeScreen ? 25.0 : 22.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A8BDF),
                  ),
                ),
                SizedBox(height: 20.0),
                _buildTextField(
                  controller: usernameController,
                  labelText: 'User Name',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  controller: vehicleRegController,
                  labelText: 'Vehicle Registration Number',
                  icon: Icons.confirmation_number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a vehicle registration number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  controller: vehicleModelController,
                  labelText: 'Vehicle Model',
                  icon: Icons.directions_car,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a vehicle model';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildDropdownField(
                  labelText: 'Vehicle Type',
                  value: selectedVehicleType,
                  items: ['Car', 'Bike', 'Truck', 'Bus'],
                  onChanged: (value) {
                    setState(() {
                      selectedVehicleType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a vehicle type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildDropdownField(
                  labelText: 'Transmission Type',
                  value: selectedTransmissionType,
                  items: ['Manual', 'Automatic', 'Electric'],
                  onChanged: (value) {
                    setState(() {
                      selectedTransmissionType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a transmission type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  controller: vehicleColorController,
                  labelText: 'Vehicle Color',
                  icon: Icons.color_lens,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a vehicle color';
                    }
                    return null;
                  },
                ),
                if (vehicleColorController.text.isNotEmpty)
                  _buildColorSuggestions(),
                SizedBox(height: 20.0),
                isLoading ? Center(child: CircularProgressIndicator()) : _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );

  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Color(0xFF4A8BDF)),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Color(0xFF4A8BDF)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Colors.blueGrey),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Colors.blueGrey, width: 2.5),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String labelText,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Color(0xFF4A8BDF)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Colors.blueGrey),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Colors.blueGrey, width: 2.5),
        ),
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildColorSuggestions() {
    return Wrap(
      spacing: 10.0,
      children: _colorSuggestions.map((color) {
        return ChoiceChip(
          label: Text(color['name']!),
          selected: vehicleColorController.text.toLowerCase() == color['name']!.toLowerCase(),
          onSelected: (isSelected) {
            setState(() {
              if (isSelected) {
                vehicleColorController.text = color['name']!;
              } else {
                vehicleColorController.text = '';
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF4A8BDF),
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 22.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        child: Text(
          'Submit',
          style: GoogleFonts.lato(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}