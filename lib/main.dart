import 'package:flutter/material.dart';
import 'package:prova_dartora/route-generator.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    onGenerateRoute: RouteGenerator
        .generateRoute,
  ));
}