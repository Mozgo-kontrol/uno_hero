import 'package:flutter/material.dart';

class ScopesPage extends StatelessWidget {
  final int tuornamentId;
  const ScopesPage({super.key, required this.tuornamentId});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      body: Center(
        child: Text('Received integer: $tuornamentId'),
      ),
    );
  }
}
