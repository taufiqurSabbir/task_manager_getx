class Urls {
  Urls._();
  static String baseurl = 'https://task.teamrabbil.com/api/v1';
  static String registation = '$baseurl/registration';
  static String login = '$baseurl/login';
  static String addNewTask = '$baseurl/createTask';
  static String new_list = '$baseurl/listTaskByStatus/New';
  static String completed = '$baseurl/listTaskByStatus/Completed';
  static String Progress = '$baseurl/listTaskByStatus/Progress';
  static String cancled = '$baseurl/listTaskByStatus/Cancelled';
  static String forgetpass = '$baseurl/RecoverVerifyEmail/';
  static String otp_varify = '$baseurl/RecoverVerifyOTP/';
  static String password_change = '$baseurl/RecoverResetPass/';
  static String taskStatusCount = '$baseurl/taskStatusCount/';
  static String profile_update = '$baseurl/profileUpdate/';


}
