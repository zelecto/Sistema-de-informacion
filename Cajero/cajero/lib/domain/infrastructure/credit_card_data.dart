import 'dart:convert';

import 'package:cajero/domain/entity/credit_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveCreditCardList(List<CreditCardEntity> list) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = list.map((card) => jsonEncode(card.toJson())).toList();
  await prefs.setString('creditCardList', jsonEncode(jsonList));
}

Future<List<CreditCardEntity>> getCreditCardList() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('creditCardList');
  if (jsonString != null) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((item) => CreditCardEntity.fromJson(jsonDecode(item)))
        .toList();
  }
  return [];
}

Future<void> addCreditCard(CreditCardEntity newCard) async {
  final list = await getCreditCardList();
  list.add(newCard);
  await saveCreditCardList(list);
}
