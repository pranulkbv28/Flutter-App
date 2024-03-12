import 'package:flutter/material.dart';
import 'package:studize_interview/services/tasks/tasks_classes.dart';
import 'package:studize_interview/services/tasks/tasks_service.dart';
import 'package:studize_interview/widgets/task_timeline.dart';
import 'package:studize_interview/widgets/subjects_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Task>> _taskListFuture;

  @override
  void initState() {
    super.initState();
    _taskListFuture = TasksService.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: Column(
        children: [
          const SubjectsGrid(),
          Expanded(
            child: FutureBuilder(
              future: _taskListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<Task> taskList = snapshot.data!;
                  return ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) => TaskTimeline(
                      task: taskList[index],
                      subjectColor: taskList[index].color,
                      isFirst: index == 0,
                      isLast: index == taskList.length - 1,
                      refreshCallback: () {
                        setState(() {
                          _taskListFuture = TasksService.getAllTasks();
                        });
                      },
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
