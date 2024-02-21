import 'package:flutter/material.dart';

class Car3 extends StatefulWidget {
  final double enlem;
  final double boylam;

  const Car3({Key? key, required this.enlem, required this.boylam})
      : super(key: key);

  @override
  State<Car3> createState() => _Car3State();
}

class _Car3State extends State<Car3> {
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
