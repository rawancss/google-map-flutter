
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var mymarkers=HashSet<Marker>();//collections
  late BitmapDescriptor customeMarker;

  getCustomeMrker()async{
    customeMarker =await BitmapDescriptor.fromAssetImage(
           ImageConfiguration.empty,'assets/images/n.jpg' );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustomeMrker();
    _polygon.add(
        Polygon(
        // given polygonId
        polygonId: PolygonId('1'),
    // initialize the list of points to display polygon
    points: points,
    // given color to polygon
    fillColor: Colors.red.withOpacity(0.6),
    // given border color to polygon
    strokeColor: Colors.red,
    geodesic: true,
    // given width of border
    strokeWidth: 4,));
  }


  Set<Polygon> _polygon = HashSet<Polygon>();

  // created list of locations to display polygon
  List<LatLng> points = [

    LatLng(18.22606160177636, 42.50147253861945),
    LatLng(18.240572366657023, 42.498725956696255),
    LatLng(18.246115485272384, 42.525161807707065),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home'),),
      body: Stack(
        children:[
          GoogleMap(
            mapType: MapType.hybrid,
            polygons: _polygon,
            onMapCreated:(googleMapController ){
              setState(() {
               mymarkers.add(
                 Marker(
                   markerId:MarkerId('1'),
                   position: LatLng(18.24688476652989, 42.51340299053494),
                    infoWindow:InfoWindow(
                      title:'cooding google map',
                      snippet:'share location'
                    ),
                   onTap:(){
                     print('marker tabed');
                   },icon: customeMarker
                 ),


               );
              });
            } ,
          initialCameraPosition:
          CameraPosition(
              target: LatLng(18.24688476652989, 42.51340299053494),
              tilt: 59.440717697143555,
              zoom: 10

          ),
          markers: mymarkers,
          ),

          Container(alignment: Alignment.bottomCenter,
            child: Text('hello map'),
          ),

          Container(alignment: Alignment.topCenter,
            child: Image.asset('assets/images/n.jpg',scale: 3,),
          ),

        
        ]
      ),
    );
  }
}
