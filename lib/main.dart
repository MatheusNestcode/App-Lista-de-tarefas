import 'package:flutter/material.dart';
import 'package:listadetarefas/pages/to_do_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoListPage(),
    );
  }
}
