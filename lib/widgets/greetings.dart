import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class Greetings extends StatelessWidget {
  String morningGreeting = 'Good morning';
  String aftGreeting = 'Good afternoon';
  String eveningGreeting = 'Good evening';

  @override
  Widget build(BuildContext context) {
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return morningGreeting;
      } else if (hour < 17) {
        return aftGreeting;
      }
      return eveningGreeting;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
          child: FittedBox(
            child: Text(
              greeting(),
              style: const TextStyle(
                fontSize: 18,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
