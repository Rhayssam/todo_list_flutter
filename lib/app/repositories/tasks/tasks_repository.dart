import 'package:todo_list_provider/app/models/task_model.dart';

abstract interface class TasksRepository {
  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end);
  Future<void> checkOrUncheckTask(TaskModel task);
}
