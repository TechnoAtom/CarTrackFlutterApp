import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Car1 extends StatefulWidget {
  final double enlem;
  final double boylam;

  const Car1({Key? key, required this.enlem, required this.boylam})
      : super(key: key);

  @override
  State<Car1> createState() => _Car1State();
}

class _Car1State extends State<Car1> {
  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition firstLocation; // `late` anahtar kelimesi ile tanımla

  @override
  void initState() {
    super.initState();
    // Gidilecek konumun başlangıçta belirlenmesi
    firstLocation = CameraPosition(
      target: LatLng(
          widget.enlem,
          widget
              .boylam), // widget ile enlem ve boylam değerlerini kullanarak başlangıç konumunu ayarla
      zoom: 18.25,
    );
  }

  Future<void> goLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(firstLocation));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Araç Takip"),
        backgroundColor: Colors.pink.shade300,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: GoogleMap(
                initialCameraPosition:
                    firstLocation, // Burada firstLocation'ı kullanıyoruz.
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(
                      controller); // Controller'ı _controller'a tamamlayarak kaydediyoruz.
                  goLocation(); // Harita oluşturulduğunda konuma git.
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
