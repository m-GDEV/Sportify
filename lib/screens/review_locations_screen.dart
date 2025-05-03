import 'package:flutter/material.dart';

class ReviewLocationsScreen extends StatelessWidget {
  const ReviewLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Locations'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          const Text(
        'Review Locations',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListTile(
        leading: const Icon(Icons.location_on),
        title: const Text('City Sports Complex'),
        subtitle: const Text('★★★★☆ 4.2'),
        onTap: () {
          // Navigate to location detail or map
        },
          ),
        ],
      ),
    );
  }
}