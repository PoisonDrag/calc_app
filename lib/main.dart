import 'package:flutter/material.dart';
import 'history.dart';
import 'home.dart';
bool dark = true;
int tab = 0;
List hist = [];
void switchTheme() {
  dark = !dark;
}
void switchTab(int t){
  tab = t;
}
void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(dark:dark, tab:tab, switchThemes: switchTheme, switchTab: switchTab, hist: hist),
      '/history': (context) => History(dark:dark, tab:tab, switchThemes: switchTheme, switchTab: switchTab, hist: hist),
    },
));
