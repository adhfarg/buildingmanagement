import 'package:flutter/material.dart';
import '../routes/routes.dart';

class BottomHomeButton extends StatelessWidget {
  const BottomHomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 16,
      child: Center(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Routes.home);
          },
          backgroundColor: Colors.grey[800],
          child: const Icon(Icons.home, color: Colors.white),
        ),
      ),
    );
  }
}
