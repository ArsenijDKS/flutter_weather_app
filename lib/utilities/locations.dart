import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer';

class Location {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }
      } else {
        Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.low)
            .timeout(Duration(seconds: 20));
        latitude = position.latitude;
        longitude = position.longitude;
      }
    } catch (e) {
      log("Something goes wrong: $e");
    }
  }
}
