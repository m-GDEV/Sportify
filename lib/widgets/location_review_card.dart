import 'package:flutter/material.dart';

class LocationReviewCard extends StatefulWidget {
  final String locationName;
  final double initialRating;
  final String locationDescription;

  const LocationReviewCard({
    super.key,
    required this.locationName,
    required this.initialRating,
    required this.locationDescription,
  });

  @override
  State<LocationReviewCard> createState() => _LocationReviewCardState();
}

class _LocationReviewCardState extends State<LocationReviewCard> {
  bool isExpanded = false;
  double userRating = 0;

  @override
  void initState() {
    super.initState();
    userRating = widget.initialRating;
  }

  void toggleCard() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void setRating(double rating) {
    setState(() {
      userRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCard,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.location_on, color: Colors.green[700]),
              title: Text(widget.locationName, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("★★★★☆ ${userRating.toStringAsFixed(1)}"),
              trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
            ),
            if (isExpanded) ...[
              const SizedBox(height: 8),
              Text(widget.locationDescription),
              const SizedBox(height: 12),
              Text("Your Rating:", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  final starIndex = index + 1;
                  return IconButton(
                    icon: Icon(
                      starIndex <= userRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () => setRating(starIndex.toDouble()),
                  );
                }),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
