enum ResourceStatus { Loading, Success, Error }

class Resource<T> {
  final ResourceStatus status;
  final T? data;
  final String message;

  Resource(this.status, this.data, this.message);

  static String WEAK_PASSWORD = "weak password";
  static String ALREADY_EXISTS = "already exists";
  static String SUCCESS = "success";
  static String REGISTER_SUCCESSFULL = "Register successfully";
  static String SOMETHING_WENT_WRONG = "something went wrong";
  static String EMAIL_ID_NOT_AVAILABLE = "No user found for that email";
  static String WRONG_PASSWORD = "Wrong password provided for that user";
  static String ACCOUNT_EXISTS_WITH_DIFFERENT_PROVIDER = "The given email id is register with different provider";
}
