import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:listadetarefas/models/lista.dart';

class ListaDeTarefas extends StatelessWidget {
  const ListaDeTarefas({
    super.key,
    required this.lista,
    required this.onDelete,
  });

  final Lista lista;
  final Function(Lista) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.5,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
                // An action can be bigger than the others.
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Deletar',
                onPressed: (_) {
                  onDelete(lista);
                }),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('dd/MM/yyyy - HH:mm').format(lista.dateTime),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                lista.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
