import 'package:floor/floor.dart';

import '../../../../../../core/utils/constants.dart';
import '../../../../domain/entities/task_list.dart';

@dao
abstract class TaskListDao {
  @Query('SELECT * FROM $kTaskListTableName')
  Future<List<TaskList>> getAllTaskLists();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertTaskList(TaskList taskList);
}
