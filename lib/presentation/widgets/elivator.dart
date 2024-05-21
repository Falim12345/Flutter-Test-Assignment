import 'package:flutter/material.dart';
import 'dart:async';

class Elevator extends ChangeNotifier {
  int _currentFloor = 0;
  final Set<int> _passedFloors = {};
  bool _isMoving = false;

  int get currentFloor => _currentFloor;
  Set<int> get passedFloors => _passedFloors;
  bool get isMoving => _isMoving;

  Future<void> moveToFloor(int targetFloor, int totalFloors) async {
    if (_isMoving) return;
    _startMoving();

    if (targetFloor == _currentFloor) {
      _stopMoving();
      return;
    }

    _passedFloors.clear();
    final direction = targetFloor > _currentFloor ? 1 : -1;

    for (int i = _currentFloor; i != targetFloor; i += direction) {
      _currentFloor = i;
      _passedFloors.add(i);
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
    }

    _currentFloor = targetFloor;
    _passedFloors.add(targetFloor);
    _stopMoving();
  }

  void _startMoving() {
    _isMoving = true;
    notifyListeners();
  }

  void _stopMoving() {
    _isMoving = false;
    notifyListeners();
  }
}
