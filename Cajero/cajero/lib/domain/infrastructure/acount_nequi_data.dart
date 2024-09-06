import 'dart:convert';
import 'package:cajero/domain/entity/acunt_nequi.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveAcuntNequiList(List<AcountNequi> list) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = list.map((account) => jsonEncode(account.toJson())).toList();
  await prefs.setString('acuntNequiList', jsonEncode(jsonList));
}

Future<List<AcountNequi>> getAcuntNequiList() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('acuntNequiList');
  if (jsonString != null) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((item) => AcountNequi.fromJson(jsonDecode(item)))
        .toList();
  }
  return [];
}

Future<void> addAcuntNequi(AcountNequi newAccount) async {
  final list = await getAcuntNequiList();
  list.add(newAccount);
  await saveAcuntNequiList(list);
}
