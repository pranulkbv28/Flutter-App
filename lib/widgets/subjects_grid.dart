import 'package:flutter/material.dart';

import '../services/tasks/tasks_classes.dart';
import '../services/tasks/tasks_service.dart';

class SubjectsGrid extends StatelessWidget {
  const SubjectsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TasksService.getSubjectList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<Subject> subjectList = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: subjectList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // adjust the number of items per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: subjectList[index].color.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(subjectList[index].name),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
