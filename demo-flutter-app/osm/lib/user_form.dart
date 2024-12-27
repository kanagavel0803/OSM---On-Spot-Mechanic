import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


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
      // Handle the form submission here
      final username = usernameController.text;
      final vehicleRegNo = vehicleRegController.text;
      final vehicleType = selectedVehicleType;
      final vehicleModel = vehicleModelController.text;
      final vehicleColor = vehicleColorController.text;
      final transmissionType = selectedTransmissionType;

      // Save to Firestore
      try {
        await FirebaseFirestore.instance.collection('vehicles').add({
          'username': username,
          'vehicle_reg_no': vehicleRegNo,
          'vehicle_type': vehicleType,
          'vehicle_model': vehicleModel,
          'vehicle_color': vehicleColor,
          'transmission_type': transmissionType,
        });

        // Show a dialog or snackbar to indicate successful submission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form submitted successfully!')),
        );

        // Navigate to GoogleMapPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleMapPage()),
        );
      } catch (e) {
        print('Error adding document: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting form.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Greeting message
                Text(
                  'Hey User!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                // Form title
                Text(
                  'Enter your vehicle details',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20.0), // Add space between title and fields
                // Username input
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'User Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0), // Add space between fields
                // Vehicle registration number input
                TextFormField(
                  controller: vehicleRegController,
                  decoration: InputDecoration(
                    labelText: 'Vehicle Registration Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a vehicle registration number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0), // Add space between fields
                // Vehicle model input
                TextFormField(
                  controller: vehicleModelController,
                  decoration: InputDecoration(
                    labelText: 'Vehicle Model',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a vehicle model';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0), // Add space between fields
                // Vehicle type selection
                DropdownButtonFormField<String>(
                  value: selectedVehicleType,
                  decoration: InputDecoration(
                    labelText: 'Vehicle Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  items: ['Car', 'Bike', 'Truck', 'Bus'].map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
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
                SizedBox(height: 16.0), // Add space between fields
                // Transmission type selection
                DropdownButtonFormField<String>(
                  value: selectedTransmissionType,
                  decoration: InputDecoration(
                    labelText: 'Transmission Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  items: ['Manual', 'Automatic', 'Electric'].map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
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
                SizedBox(height: 16.0), // Add space between fields
                // Vehicle color input with color previews
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return _colorSuggestions.where((color) {
                      return color['name']!.toLowerCase().contains(
                            textEditingValue.text.toLowerCase(),
                          );
                    }).map((color) => color['name']!);
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    vehicleColorController.text = textEditingController.text;
                    return TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: 'Vehicle Color',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a vehicle color';
                        }
                        return null;
                      },
                    );
                  },
                  onSelected: (String selection) {
                    vehicleColorController.text = selection;
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Material(
                      child: ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final colorName = options.elementAt(index);
                          final colorHex = _colorSuggestions
                              .firstWhere(
                                (color) => color['name'] == colorName,
                                orElse: () => {'hex': '#FFFFFF'},
                              )['hex'];
                          return ListTile(
                            title: Text(colorName),
                            leading: CircleAvatar(
                              backgroundColor: Color(int.parse(colorHex!.substring(1, 7), radix: 16) + 0xFF000000),
                            ),
                            onTap: () => onSelected(colorName),
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.0), 
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}