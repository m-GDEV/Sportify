import 'package:flutter/material.dart';

class PlayerTile extends StatelessWidget {
  final String name;
  final String sport;
  final String time;
  final double rating;
  final double? distance;

  const PlayerTile({
    Key? key,
    required this.name,
    required this.sport,
    required this.time,
    required this.rating,
    this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green[200],
            child: Text(name[0]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text('$sport • $time', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                if (distance != null)
                  Text('${distance!.toStringAsFixed(1)} km away', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Column(
            children: [
              Icon(Icons.star, color: Colors.amber[600], size: 20),
              Text(rating.toString(), style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          )
        ],
      ),
    );
  }
}
