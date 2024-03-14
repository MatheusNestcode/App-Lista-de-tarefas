import 'package:flutter/material.dart';
import 'package:listadetarefas/models/lista.dart';

import '../widgets/lista_de_tarefas.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  //controlador para pegar as informaçoes do campo texto
  final TextEditingController tarefasControle = TextEditingController();

//lista de strings
  List<Lista> tarefas = [];
  Lista? deletarTarefa;
  int? deletarTarefaPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        //paramentro para pegar o texto
                        controller: tarefasControle,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicione uma tarefa',
                          hintText: 'Ex. Estudar flutter',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //usar o texto capturado com ação do botão
                        String text = tarefasControle.text;
                        //comando para atualizar o estado da lista
                        setState(() {
                          Lista newLista =
                              Lista(title: text, dateTime: DateTime.now());
                          tarefas.add(newLista);
                        });
                        tarefasControle.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: const Color(0xff00d7f3),
                        padding: const EdgeInsets.all(18),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),

                //espaçamento de widgets
                const SizedBox(height: 16),
                //comando para criar lista
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      //condição para adicionar os itens na lista
                      for (Lista tarefa in tarefas)
                        ListaDeTarefas(
                          lista: tarefa,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          'Você possui ${tarefas.length} tarefas pendentes'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: mostrarCaixaDeDialogoParaExcluir,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: const Color(0xff00d7f3),
                        padding: const EdgeInsets.all(18),
                      ),
                      child: const Text('Limpar tudo'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Lista tarefa) {
    deletarTarefa = tarefa;
    deletarTarefaPos = tarefas.indexOf(tarefa);

    setState(() {
      tarefas.remove(tarefa);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa ${tarefa.title} foi deletada com sucesso'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              tarefas.insert(deletarTarefaPos!, deletarTarefa!);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void mostrarCaixaDeDialogoParaExcluir() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar tudo?'),
        content: const Text(
            'Voce tem certeza que deseja apagar todos as tarefas da sua lista ?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deletarTodasAsTarefas();
            },
            child: const Text('Deletar'),
          ),
        ],
      ),
    );
  }

  void deletarTodasAsTarefas() {
    setState(() {
      tarefas.clear();
    });
  }
}
