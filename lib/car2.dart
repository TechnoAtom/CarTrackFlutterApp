import 'package:flutter/material.dart';

class Car2 extends StatefulWidget {
  final double enlem;
  final double boylam;

  const Car2({Key? key, required this.enlem, required this.boylam})
      : super(key: key);

  @override
  State<Car2> createState() => _Car2State();
}

class _Car2State extends State<Car2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Araç Takip"),
        backgroundColor: Colors.pink.shade300,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enlem: ${widget.enlem}"),
            Text("Boylam: ${widget.boylam}"),
          ],
        ),
      ),
    );
  }
}
