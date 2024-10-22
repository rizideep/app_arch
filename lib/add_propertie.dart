import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_olx/property_listscreen.dart';

class PropertyListingScreen extends StatefulWidget {
  const PropertyListingScreen({super.key});

  @override
  PropertyListingScreenState createState() => PropertyListingScreenState();
}

class PropertyListingScreenState extends State<PropertyListingScreen> {
  final _formKey = GlobalKey<FormState>();
  List<XFile?> _images = [null, null, null]; // Placeholder for 3 images
  final ImagePicker _picker = ImagePicker();

  // Controllers for TextFields
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  // Pick a single image and assign it to the corresponding ImageView
  Future<void> _pickImage(int index) async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _images[index] = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Property Listing',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Image picker section
                const Text(
                  "Property Photos (Up to 3)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                _buildImageView(index),
                                const SizedBox(height: 5),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.deepPurpleAccent,
                                  ),
                                  onPressed: () => _pickImage(index),
                                  child: Text("Image ${index + 1}"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: 3,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal),
                ),

                const SizedBox(height: 20),

                // Area TextField with Icon
                _buildTextField(
                  _areaController,
                  "Area of Property",
                  icon: Icons.landscape,
                ),

                // Budget TextField with Icon
                _buildTextField(
                  _budgetController,
                  "Budget",
                  icon: Icons.money,
                  keyboardType: TextInputType.number,
                ),

                // Address TextField with Icon
                _buildTextField(
                  _addressController,
                  "Address",
                  icon: Icons.location_on,
                ),

                // Contact TextField with Icon
                _buildTextField(
                  _contactController,
                  "Contact Details",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 30),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>   PropertyListScreen()),
                      );
                      // if (_formKey.currentState!.validate()) {
                      //   // Handle form submission
                      //   ScaffoldMessenger.of(context)
                      //       .showSnackBar(const SnackBar(
                      //     content: Text('Property Listing Added'),
                      //   ));
                      // }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function for consistent TextFields styling with icons
  Widget _buildTextField(
    TextEditingController controller,
    String labelText, {
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.deepPurple,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.deepPurple,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  // Build image view for each selected image
  Widget _buildImageView(int index) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: _images[index] != null
            ? Image.file(
                File(_images[index]!.path),
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image, color: Colors.grey),
      ),
    );
  }
}


