import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:fruit_and_veggies_recognition/models/result.dart';

class MyProvider with ChangeNotifier {
  List<Result> _results = [];

  List<Result> get results => _results;

  void addResult(Result newResult) {
    _results.add(newResult);
    notifyListeners();
  }

  Future<List<Result>> readResult() async {
    return _results;
  }
}
