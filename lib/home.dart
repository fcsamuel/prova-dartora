import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _position = CameraPosition(target: LatLng(-24.720739, -53.713464), zoom: 10);
  Set<Marker> _marcadores = {};
  Set<Polygon> _polygons = {};
  Set<Polyline> _polylines = {};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  _onMapCreate(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  _recuperarLocalizacao() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final Marker marker = Marker(
      markerId: MarkerId("marker"),
      position: LatLng(position.latitude, position.longitude),
      infoWindow: InfoWindow(title: 'Posicao: '+position.latitude.toString() +' - '+ position.longitude.toString()),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    setState(() {
      _position = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 10);
      markers[MarkerId("marker")] = marker;
    });
  }

  _movimentarCamera() async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(-24.7208, -53.7127), zoom: 20, tilt: 0, bearing: 270
    )));
  }

  _carregarMarcadores() {
    Set<Marker> marcadoresLocalAtual = {};
    Marker marcadorCasa = Marker(
      markerId: MarkerId("marcador-casa"),
      position: LatLng(-24.720739, -53.713464),
      infoWindow: InfoWindow(title: "Felipe's House"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta)
    );

    marcadoresLocalAtual.add(marcadorCasa);

    Set<Polygon> listaPolygons = {};
    Set<Polyline> listaPolylines = {};

    Polygon polygon1 = Polygon(
      polygonId: PolygonId("polygon1"),
      fillColor: Colors.green,
      strokeColor: Colors.black,
      strokeWidth: 20,
      points: [
        LatLng(-24.732742, -53.743253),
        LatLng(-24.733111, -53.742363),
        LatLng(-24.735314, -53.743495)
      ],
    );
    listaPolygons.add(polygon1);

    Polyline polyline1 = Polyline(
      polylineId: PolylineId("polyline1"),
      color: Colors.red,
      width: 4,
      startCap: Cap.roundCap,
      points: [
        LatLng(-24.732742, -53.743253),
        LatLng(-24.733111, -53.742363)
      ]
    );

    listaPolylines.add(polyline1);


    setState(() {
      _marcadores = marcadoresLocalAtual;
      _polygons = listaPolygons;
      _polylines = listaPolylines;
    });
  }

  _recuperarLocalUsuario() async {
    Position position = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    setState(() {
      _position;
      _movimentarCamera();
    });
    print("Posição atual: " + position.toString());
  }

  @override
  void initState() {
    super.initState();
    _recuperarLocalizacao();
    _carregarMarcadores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Geolocalização"),),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: _movimentarCamera
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _position,
          onMapCreated: _onMapCreate,
          markers: _marcadores,
          polygons: _polygons,
          polylines: _polylines,
        ),
      ),
    );
  }
}
