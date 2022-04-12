// Database
const String kDatabaseName = "tasks.db";

// todo table
const String kTodoTableName = 'tasks';

const String kTaskColId = 'id';
const String kTaskColName = 'name';
const String kTaskColDue = 'due';
const String kTaskColAlert = 'hasAlert';
const String kTaskColCompleted = 'isDone';
const String kTaskColRepeatMode = 'repeatMode';
const String kTaskColTaskListId = 'taskListId';

// Task list Table
const String kTaskListTableName = 'task_lists';

// Todo list type

const String kTodayTodo = "Today's Task";
const String kOverdueTodo = "Overdue Task";
const String kUpcomingTodo = "Upcoming Task";

/*
* Constants to be used throughout the app for shared Preferences
*/
const String SETTING_THEME = 'theme';
const String SETTING_CONFIRMATION_ON_COMP_TASK = 'ConfirmOnCompTask';
