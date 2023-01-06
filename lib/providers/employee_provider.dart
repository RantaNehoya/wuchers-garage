import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmployeeProvider with ChangeNotifier {
  String _selectedEmployee = '';
  final String _currentEmployeeUID = FirebaseAuth.instance.currentUser?.uid ?? '';
  final String? _currentEmployee =
      FirebaseAuth.instance.currentUser!.displayName ?? '';

  //getters
  String get getSelectedEmployee => _selectedEmployee;

  String get getCurrentEmployeeUID => _currentEmployeeUID;

  String? get getCurrentEmployee => _currentEmployee;

  //setters
  void setSelectedEmployee(String newEmployee) {
    _selectedEmployee = newEmployee;
    notifyListeners();
  }
}
