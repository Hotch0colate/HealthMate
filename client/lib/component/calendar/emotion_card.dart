import 'package:flutter/material.dart';

class EmotionCard extends StatelessWidget {
  final String time;
  final String name;
  final String description;
  final IconData icon;

  const EmotionCard({
    Key? key,
    required this.time,
    required this.name,
    required this.description,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(time, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Icon(icon, size: 50), // Placeholder for the pet image
            ],
          ),
          SizedBox(height: 8),
          Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }
}