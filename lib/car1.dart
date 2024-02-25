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
  late CameraPosition firstLocation;
  Set<Marker> _markers = {}; // Marker'ları tutacak set

  @override
  void initState() {
    super.initState();
    firstLocation = CameraPosition(
      target: LatLng(widget.enlem, widget.boylam),
      zoom: 18.25,
    );

    // initState içinde marker'ı ekleyin
    _markers.add(
      Marker(
        // Marker için benzersiz bir id verin
        markerId: MarkerId('car_location'),
        // Marker'ın konumunu belirleyin
        position: LatLng(widget.enlem, widget.boylam),
        infoWindow: InfoWindow(
          // Marker'a tıklanınca gösterilecek başlık ve açıklama
          title: 'Araç Konumu',
          snippet: 'Burada aracınız bulunuyor.',
        ),
        icon: BitmapDescriptor
            .defaultMarker, // Opsiyonel: Marker ikonunu değiştirebilirsiniz
      ),
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
              width: 500,
              height: 600,
              child: GoogleMap(
                initialCameraPosition: firstLocation,
                mapType: MapType.normal,
                markers: _markers, // Marker setini GoogleMap widget'ına ekleyin
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  goLocation();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
