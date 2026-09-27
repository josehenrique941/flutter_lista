import 'package:flutter/material.dart';

void main() {
  runApp(const ListaTarefasApp());
}

class ListaTarefasApp extends StatelessWidget {
  const ListaTarefasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tarefas',
      theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true),
      home: const ListaTarefasScreen(),
    );
  }
}

class TaskItem {
  String title;
  bool isDone;
  TaskItem({required this.title, this.isDone = false});
}

class ListaTarefasScreen extends StatefulWidget {
  const ListaTarefasScreen({super.key});

  @override
  State<ListaTarefasScreen> createState() => _ListaTarefasScreenState();
}

class _ListaTarefasScreenState extends State<ListaTarefasScreen> {
  final List<TaskItem> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _tasks.add(TaskItem(title: _controller.text.trim()));
        _controller.clear();
      });
    }
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas - Lab 3'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Adicionar nova tarefa...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  onPressed: _addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(child: Text('Nenhuma tarefa cadastrada.'))
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: Checkbox(
                              value: _tasks[index].isDone,
                              onChanged: (_) => _toggleTask(index),
                            ),
                            title: Text(
                              _tasks[index].title,
                              style: TextStyle(
                                decoration: _tasks[index].isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                              onPressed: () => _removeTask(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
