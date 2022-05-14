import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ECG Analysis'),
      ),
      body: Container(
        child: Center(
          child: Text('Response from the server goes here'),
        ),
      ),
    );
  }
}
