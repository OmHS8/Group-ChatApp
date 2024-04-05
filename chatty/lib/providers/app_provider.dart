import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{
  bool themeMode;
  AppProvider() : themeMode = false;

  bool get isDark => themeMode;

  void toggleThemeMode(bool? value){
    if(value != null){
      themeMode = value; 
    }else{
      themeMode = !themeMode;
    }
    notifyListeners();
  }
}