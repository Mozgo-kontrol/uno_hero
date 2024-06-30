import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdPlaceholderWidget extends StatelessWidget {
  const AdPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      height: 80,
      width: double.infinity,
      child: const Center(
        child: Text(
          'ADS',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}