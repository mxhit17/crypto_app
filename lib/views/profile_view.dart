import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircleAvatar(
        radius: 150,
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.person),
      ),
    );
  }
}
