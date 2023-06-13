import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/routes/api_routes.dart';
import 'providers/providers.dart';

main() async{
  final prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
    child: MaterialApp.router(routerConfig: router)) );
}