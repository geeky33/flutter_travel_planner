import 'package:flutter/material.dart';

class TripPlace {
  final String name;
  bool visited;
  final IconData icon;
  final Color color;
  final double latitude;
  final double longitude;

  TripPlace({
    required this.name,
    required this.visited,
    required this.icon,
    required this.color,
    required this.latitude,
    required this.longitude,
  });
}

class TripData extends ChangeNotifier {
  TripData._();

  static final TripData instance = TripData._();

  final List<TripPlace> places = [
    TripPlace(
      name: 'Baga Beach',
      visited: true,
      icon: Icons.beach_access_rounded,
      color: Colors.orange,
      latitude: 15.5557,
      longitude: 73.7517,
    ),
    TripPlace(
      name: 'Fort Aguada',
      visited: false,
      icon: Icons.castle_rounded,
      color: Colors.deepPurple,
      latitude: 15.4920,
      longitude: 73.7730,
    ),
    TripPlace(
      name: 'Dudhsagar Falls',
      visited: false,
      icon: Icons.water_drop_rounded,
      color: Colors.blue,
      latitude: 15.3144,
      longitude: 74.3144,
    ),
    TripPlace(
      name: 'Basilica of Bom Jesus',
      visited: false,
      icon: Icons.account_balance_rounded,
      color: Colors.green,
      latitude: 15.5009,
      longitude: 73.9117,
    ),
    TripPlace(
      name: 'Palolem Beach',
      visited: false,
      icon: Icons.waves_rounded,
      color: Colors.teal,
      latitude: 15.0100,
      longitude: 74.0232,
    ),
  ];

  int get visitedCount {
    return places.where((place) => place.visited).length;
  }

  int get totalPlaces => places.length;

  double get progress {
    if (places.isEmpty) return 0;
    return visitedCount / totalPlaces;
  }

  TripPlace? get nextDestination {
    for (final place in places) {
      if (!place.visited) {
        return place;
      }
    }

    return null;
  }

  void toggleVisited(int index, bool value) {
    places[index].visited = value;
    notifyListeners();
  }

  void addPlace(String name) {
    places.add(
      TripPlace(
        name: name,
        visited: false,
        icon: Icons.place_rounded,
        color: Colors.blue,
        // New places don't have coordinates yet.
        // They can be added to the map later.
        latitude: 0,
        longitude: 0,
      ),
    );

    notifyListeners();
  }

  void removePlace(int index) {
    places.removeAt(index);
    notifyListeners();
  }

  void restorePlace(int index, TripPlace place) {
    places.insert(index, place);
    notifyListeners();
  }
}
