import 'dart:collection';
import 'package:cripto_moedas_flutter/model/Moeda.dart';
import 'package:flutter/cupertino.dart';

class FavoritasRepository extends ChangeNotifier {
  final List<Moeda> _lista = [];

  UnmodifiableListView<Moeda> get lista => UnmodifiableListView(_lista);

  saveAll(List<Moeda> moedas) {
    for (var moeda in moedas) {
      if (!_lista.contains(moeda)) _lista.add(moeda);
    }
    notifyListeners();
  }

  remove(Moeda moeda) {
    _lista.remove(moeda);
    notifyListeners();
  }
}
