import 'dart:convert';

import 'package:listadetarefas/models/lista.dart';
import 'package:shared_preferences/shared_preferences.dart';

const listaKey = 'listadetarefas';

class ListaRepository {
  late SharedPreferences sharedPreferences;

  Future<List<Lista>> getListadeTarefas() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString(listaKey) ?? '[]';
    final List jsonDecoded = jsonDecode(jsonString) as List;
    return jsonDecoded.map((e) => Lista.fromJson(e)).toList();
  }

  void saveLista(List<Lista> lista) {
    final jsonString = json.encode(lista);
    sharedPreferences.setString(listaKey, jsonString);
  }
}
