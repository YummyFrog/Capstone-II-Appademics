import 'package:flutter/material.dart';

class GridViewTutorProfiles extends StatelessWidget{
  GridViewTutorProfiles({super.key});

  final int itemCount = 20;


@override
Widget build(BuildContext context) {
  return GridView.builder(
    itemCount: itemCount,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        color: Colors.blue.shade100,
        child: Center(
          child: Text(
            'Tutor #${index + 1}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      );
    },
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1/1.5, // Width : Height of Tutor Profiles on HomePage
    ),
    padding: const EdgeInsets.all(16),
    scrollDirection: Axis.vertical,
    reverse: false,
    physics: const BouncingScrollPhysics(),
  );
}
}
