import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Container(
              child:Row(children: [
                  Container(
                    child: OutlinedButton(
                        onPressed:(){ Navigator.pop(context);},
                        child: Icon(Icons.arrow_back),
                       style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: Colors.white),)
                    ),

                  ),
                  Text("Events", style: TextStyle(fontSize: 20),)
              ],
            ),
              padding: EdgeInsets.all(0),
            )

        ) ,
      body: 
   
        FlutterMap(
        options: MapOptions(
          bounds: LatLngBounds(LatLng(58.8, 6.1), LatLng(59, 6.2)),
          boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(8.0)),
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(58.9, 6.15),
                builder: (ctx) => Container(
                  child: SizedBox(
                    height: 18.0,
                    width: 18.0,
                    child: Icon(
                      Icons.add_location,
                      color: Color.fromRGBO(128, 0, 32, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        children: <Widget>[
          TileLayerWidget(
              options: TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'])),
          MarkerLayerWidget(
              options: MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(51.5, -0.09),
                builder: (ctx) => Container(
                  child: Icon(
                    Icons.person,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
