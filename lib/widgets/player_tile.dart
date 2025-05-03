import 'package:flutter/material.dart';

class PlayerTile extends StatelessWidget {
  final String name;
  final String sport;
  final String time;
  final double rating;
  final double? distance; // optional

  const PlayerTile({
    super.key,
    required this.name,
    required this.sport,
    required this.time,
    required this.rating,
    this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(child: Text(name[0])),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$sport at $time'),
            if (distance != null)
              Text(
                '${distance!.toStringAsFixed(1)} km away',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (i) => Icon(
              i < rating.round() ? Icons.star : Icons.star_border,
              size: 16,
              color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
