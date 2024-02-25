import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'car1.dart';
import 'car2.dart';
import 'car3.dart';
import 'dart:convert'; // JSON işlemleri için gerekli
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double enlem = 60.2151778;
  double boylam = 28.3582383;
  int hiz = 0;
  int ident = 352016700333305;

  Future<void> getLocation() async {
    var konum = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // HTTP GET isteği yap
    final response = await http.get(Uri.parse('http://10.0.2.2:5087/api/GPS'));

    if (response.statusCode == 200) {
      // Cevabı JSON'a çevir
      var jsonData = jsonDecode(response.body);

      // JSON'dan enlem ve boylamı al (JSON yapınıza göre değişiklik gösterebilir)
      var latitude = jsonData['position.latitude'];
      var longitude = jsonData['position.longitude'];
      var hiz = jsonData['position.speed'];
      var ident = jsonData['ident'];
      setState(() {
        // Alınan konumu ve API'den gelen enlem ve boylamı değişkenlere ata
        enlem = latitude;
        boylam = longitude;
      });
    } else {
      // Hata durumunda bir şeyler yap
      print('Sunucudan veri alınamadı');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Araç Takip"),
        backgroundColor: Colors.pink.shade300,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                await getLocation();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Car1(enlem: enlem, boylam: boylam),
                  ),
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      // İlk ikon ve başlığı
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.directions_car), // İlk ikon (araba)
                          SizedBox(height: 4), // İkon ve başlık arasında boşluk
                          Text('Araç:352016700333305'), // İkona ait başlık
                        ],
                      ),
                      SizedBox(width: 20), // İkonlar arasında boşluk
                      // İkinci ikon ve başlığı
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.vpn_key), // İkinci ikon (anahtar)
                          SizedBox(height: 4), // İkon ve başlık arasında boşluk
                          Text('İlk Kontak: ------'), // İkona ait başlık
                        ],
                      ),
                      Spacer(), // İkonlar ile hız bilgisini ayırmak için
                      // Hız bilgisi
                      Text('Hız: $hiz km/s'),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await getLocation();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Car1(enlem: enlem, boylam: boylam),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text('Araç 2'),
                  subtitle: Text('Açıklama 2'),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await getLocation();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Car1(enlem: enlem, boylam: boylam),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text('Araç 3'),
                  subtitle: Text('Açıklama 3'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
