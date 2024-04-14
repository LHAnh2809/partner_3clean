import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/firebase/firestire_service_get.dart';

class Constants {
  const Constants._();

  // Method to fetch data from Firestore and set baseUrl

  static const String baseVietMapUrl = 'https://maps.vietmap.vn/api';
  //deelay.me - api to delay response

  static const timeout = Duration(milliseconds: 30000);
  static const String apiKeyVietMap =
      '506862bb03a3d71632bdeb7674a3625328cb7e5a9b011841';
  static const String token = 'authToken';
  static const String tokenSocket = 'tokenSocket';
}
