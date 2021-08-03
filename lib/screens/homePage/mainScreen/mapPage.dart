import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class MapPage extends StatefulWidget {
  final latitude ;
  final longitude ;

  const MapPage({Key key, this.latitude, this.longitude}) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(
         backgroundColor: Color.fromRGBO(36, 34, 47, 1),
            
            leading: IconButton(
              
                        onPressed:(){ Navigator.pop(context);},
                        icon: Icon(Icons.arrow_back,color: Color.fromRGBO(170, 215, 62, 1),),
                       
                    ),

                  ),
             
              
            
             
            

        
      body: 
   
        FlutterMap(
            options: new MapOptions(
              center: new LatLng(widget.latitude.toDouble(), widget.longitude.toDouble()),
              zoom: 13.0,
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
                point: LatLng(widget.latitude.toDouble(), widget.longitude.toDouble()),
                builder: (ctx) => Container(
                  child: SizedBox(
                    height: 18.0,
                    width: 18.0,
                    child: Icon(
                      FontAwesomeIcons.mapMarkerAlt,
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
                point: LatLng(widget.latitude.toDouble(), widget.longitude.toDouble()),
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
