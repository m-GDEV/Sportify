import 'package:flutter/material.dart';

class ReviewLocationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> locations = [
    {
      'name': 'City Sports Complex',
      'image': 'https://harborsquare.com/wp-content/uploads/2021/12/full-court-basketball-indoors-near-me-edmonds-copy.jpg',
      'courts': '3 outdoor, 1 indoor',
      'rating': 4.5,
      'distance': '1.2 km'
    },
    {
      'name': 'West Park Field',
      'image': 'https://luthernorse.com/images/2021/12/3/Soccer_Pitch_III.jpg',
      'courts': '2 soccer fields',
      'rating': 4.2,
      'distance': '0.8 km'
    },
    {
      'name': 'Arena 21',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6k55pclXE2vMHVxyiQ866WMGd93bpufMv_g&s',
      'courts': '5 indoor courts',
      'rating': 4.7,
      'distance': '2.1 km'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 12),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFA8E6A2),
                Color(0xFF6FCF97),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("📍", style: TextStyle(fontSize: 26)),
                SizedBox(width: 10),
                Text(
                  'Nearby Locations',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              border: Border.all(color: Colors.green.shade100),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    location['image'],
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(location['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text('🏟️ Courts: ${location['courts']}'),
                      Text('📍 ${location['distance']} • ⭐ ${location['rating']}'),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
