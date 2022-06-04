import 'package:flutter/material.dart';
import 'package:pokedex/data/gateways/core_gateway.dart';
import 'package:pokedex/domain/entities/type_entity.dart';

class TypesViewController extends ChangeNotifier {
  static ValueNotifier<bool> isTypeInformationLoaded = ValueNotifier(false);

  static void initialize(TypeEntity type) async {
    isTypeInformationLoaded.value = false;
    await CoreGateway.getTypeInformationByName(type);
    isTypeInformationLoaded.value = true;
    isTypeInformationLoaded.notifyListeners();
  }
}
