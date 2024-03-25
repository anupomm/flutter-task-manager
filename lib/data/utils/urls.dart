class Urls{
  Urls._();
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newListTasks = '$_baseUrl/listTaskByStatus/New';
  static String progressListTasks = '$_baseUrl/listTaskByStatus/Progress';
  static String cancelledListTasks = '$_baseUrl/listTaskByStatus/Canceled';
  static String completedListTasks = '$_baseUrl/listTaskByStatus/Completed';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTask(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';
}