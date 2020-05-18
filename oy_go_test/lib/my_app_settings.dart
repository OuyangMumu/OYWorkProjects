/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020-05-01
 */

import 'package:flutter/material.dart';
import 'package:oy_go_test/routes/routeSettings/my_app_routes.dart' show AllRouts;
import 'package:oy_go_test/routes/routeSettings/my_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppSettings extends ChangeNotifier {
  static const darkModePreferenceKey = "Dark_Mode";
  static const searchHistoryPreferenceKey = "Search_History";
  static const bookMarksRoutesPreferenceKey = "BookMarks_Routes";

  static final routeNameToRouteMap = {
    for (MyRoute route in AllRouts) route.routeName: route
  };

  final SharedPreferences _preferences;

  MyAppSettings(this._preferences);

  bool get isDarkMode {
    return _preferences?.getBool(darkModePreferenceKey) ?? false;
  }

  void setDarkMode(bool dark) {
    _preferences?.setBool(darkModePreferenceKey, dark);
    notifyListeners();
  }

  List<String> get searchHistory {
    return _preferences.getStringList(searchHistoryPreferenceKey) ?? [];
  }

  void addSearchHistory(String routeName) {
    List<String> history = this.searchHistory;
    history.remove(routeName);
    history.insert(0, routeName);
    if (history.length >= 10) {
      history = history.take(10).toList();
    }
    _preferences?.setStringList(searchHistoryPreferenceKey, history);
  }

  List<String> get starredRouteNames {
    return _preferences?.getStringList(bookMarksRoutesPreferenceKey) ?? [];
  }

  List<MyRoute> get starredRoutes => [
    for (String routeName in this.starredRouteNames)
      if (routeNameToRouteMap[routeName] != null)
         routeNameToRouteMap[routeName]
  ];

  Widget starStatusOfRoute(String routeName) {
    return IconButton(
      tooltip: "BookMark",
      icon: Icon(
        this.isStarred(routeName) ? Icons.star : Icons.star_border,
        color: this.isStarred(routeName) ? Colors.yellow : Colors.grey,
      ),
      onPressed: () {
        this.toggleStarred(routeName);
      },
    );
  }

  bool isStarred(String routeName) {
    return starredRouteNames.contains(routeName) ?? false;
  }

  void toggleStarred(String routeName) {
    final starredRoutes = this.starredRouteNames;
    if (isStarred(routeName)) {
      starredRoutes.remove(routeName);
    } else {
      starredRoutes.add(routeName);
    }

    final dedupenStarendRoutes = Set<String>.from(starredRoutes).toList();
    _preferences?.setStringList(
        bookMarksRoutesPreferenceKey, dedupenStarendRoutes);
    notifyListeners();
  }
}
