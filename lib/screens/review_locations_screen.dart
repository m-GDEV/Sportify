import 'package:flutter/material.dart';

class ReviewLocationsScreen extends StatefulWidget {
  @override
  State<ReviewLocationsScreen> createState() => _ReviewLocationsScreenState();
}

class _ReviewLocationsScreenState extends State<ReviewLocationsScreen> {
  final List<Map<String, dynamic>> locations = [
    {
      'name': 'City Sports Complex',
      'image': 'https://harborsquare.com/wp-content/uploads/2021/12/full-court-basketball-indoors-near-me-edmonds-copy.jpg',
      'courts': '3 outdoor, 1 indoor',
      'rating': 4.5,
      'distance': '1.2 km',
      'capacity': 'Up to 150 players',
      'hours': '6:00 AM – 11:00 PM',
    },
    {
      'name': 'West Park Field',
      'image': 'https://luthernorse.com/images/2021/12/3/Soccer_Pitch_III.jpg',
      'courts': '2 soccer fields',
      'rating': 4.2,
      'distance': '0.8 km',
      'capacity': 'Up to 80 players',
      'hours': '7:00 AM – 10:00 PM',
    },
    {
      'name': 'Arena 21',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6k55pclXE2vMHVxyiQ866WMGd93bpufMv_g&s',
      'courts': '5 indoor courts',
      'rating': 4.7,
      'distance': '2.1 km',
      'capacity': 'Up to 200 players',
      'hours': 'Open 24/7',
    },
  ];

  final Set<int> expandedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B5E20), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
            titleSpacing: 16,
            title: const Text(
              'Nearby Locations',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          final isExpanded = expandedIndexes.contains(index);

          return GestureDetector(
            onTap: () {
              setState(() {
                if (isExpanded) {
                  expandedIndexes.remove(index);
                } else {
                  expandedIndexes.add(index);
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                border: Border.all(color: Colors.green.shade800),
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
                        Text(
                          location['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text('🏟️ Courts: ${location['courts']}', style: const TextStyle(color: Colors.white)),
                        Text('📍 ${location['distance']} • ⭐ ${location['rating']}', style: const TextStyle(color: Colors.white)),
                        if (isExpanded) ...[
                          const SizedBox(height: 8),
                          Divider(color: Colors.green[900], thickness: 0.5),
                          const SizedBox(height: 8),
                          Text('👥 Capacity: ${location['capacity']}', style: const TextStyle(color: Colors.white)),
                          Text('⏰ Hours: ${location['hours']}', style: const TextStyle(color: Colors.white)),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
