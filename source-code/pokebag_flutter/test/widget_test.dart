// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/widgets.dart';
// import 'package:pokebag_flutter/app/data/models/response/pokemon/detail/poke-detail_response.dart';
// import 'package:pokebag_flutter/app/data/models/response/pokemon/list/poke-list_response.dart';
// import 'package:pokebag_flutter/app/services/remote_services.dart';

import '../lib/app/constants/random_number.dart';

void main() async {
  probability() {
    int length = 7;
    NRandom nrand = NRandom(length);

    final index = nrand.getNextIndex();

    return index;
  }

  debugPrint(probability().toString());
}
