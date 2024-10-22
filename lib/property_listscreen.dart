import 'package:flutter/material.dart';

class PropertyListScreen extends StatelessWidget {
  final List<Property> properties = [
    Property(
      id: '1',
      area: '1200 sqft',
      budget: '₹50,00,000',
      address: '123, Palm Street, Delhi',
      contact: '9876543210',
      imagePath: 'assets/images/h.jpg',
      category: 'Residential',  // New field
      areaType: 'City',         // New field
    ),
    Property(
      id: '2',
      area: '1500 sqft',
      budget: '₹70,00,000',
      address: '45, Rose Avenue, Mumbai',
      contact: '9876543211',
      imagePath: 'assets/images/gh.jpg',
      category: 'Commercial',   // New field
      areaType: 'City',         // New field
    ),
    Property(
      id: '3',
      area: '1000 sqft',
      budget: '₹40,00,000',
      address: '78, Lotus Colony, Bangalore',
      contact: '9876543212',
      imagePath: 'assets/images/ghar.jpg',
      category: 'Agriculture',  // New field
      areaType: 'Tehsil',       // New field
    ),
    Property(
      id: '4',
      area: '1900 sqft',
      budget: '₹80,00,000',
      address: '123, Palm Street, Delhi',
      contact: '9876546710',
      imagePath: 'assets/images/h.jpg',
      category: 'Residential',  // New field
      areaType: 'Tehsil',       // New field
    ),
  ];

  PropertyListScreen({super.key});


  // Filter properties by category
  List<Property> filterByCategory(String selectedCategory) {
    return properties.where((property) => property.category == selectedCategory).toList();
  }

// Filter properties by area type (City or Tehsil)
  List<Property> filterByAreaType(String selectedAreaType) {
    return properties.where((property) => property.areaType == selectedAreaType).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Property Listings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurpleAccent.withOpacity(0.9),
              Colors.blueAccent.withOpacity(0.9),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: properties.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1/1.4
            ),
            itemBuilder: (context, index) {
              final property = properties[index];
              return Hero(
                tag: property.id, // Unique tag for Hero animation
                child: _buildPropertyCard(context, property),
              );
            },
          ),
        ),
      ),
    );
  }

  // Function to build each property card
  Widget _buildPropertyCard(BuildContext context, Property property) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Container( // Removed Flexible
        height: 500, // Fixed height to manage content
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PropertyDetailsScreen(property: property),
              ),
            );
          },
          child: Column( // Changed Wrap to Column for proper layout
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  property.imagePath,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPropertyInfo(Icons.landscape, property.area),
                    _buildPropertyInfo(Icons.money, property.budget),
                    _buildPropertyInfo(Icons.location_on, property.address),
                    _buildPropertyInfo(Icons.phone, property.contact),
                  ],
                ),
              ),

              const SizedBox(height: 2),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to display property info with icons
  Widget _buildPropertyInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.deepPurple,size: 15,),
          const SizedBox(width: 5),
          Expanded( // Wrap text in Expanded to avoid overflow
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis, // Handle text overflow
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyDetailsScreen extends StatelessWidget {
  final Property property;

  const PropertyDetailsScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Hero(
          tag: property.id,
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      property.imagePath,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    property.area,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(property.budget),
                  const SizedBox(height: 10),
                  Text(property.address),
                  const SizedBox(height: 10),
                  Text('Contact: ${property.contact}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      // Navigate back
                      Navigator.pop(context);
                    },
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Property model class
class Property {
  final String id;
  final String area;
  final String budget;
  final String address;
  final String contact;
  final String imagePath;
  final String category;   // New field for category-wise listing
  final String areaType;   // New field for area-wise listing

  Property({
    required this.id,
    required this.area,
    required this.budget,
    required this.address,
    required this.contact,
    required this.imagePath,
    required this.category,   // Initialize new field
    required this.areaType,   // Initialize new field
  });
}

