import 'package:indrayani/utils/initialization_services/singleton_service.dart';

//Auth related end points
String getOTPForEnteredMobileNumberEndPoint = "auth/verify";
String verifyOtpEndPoint = "auth/verify";
String signupEndPoint = "auth/signup";
String loginEndPoint = "auth/login";

//Exams related end points
String trendingExamListEndPoint =
    "getexams?type=trending&user_id= ${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.userId ?? 0}";
String trendingExamDetailsEndPoint({required String examId}) =>
    "exam?CAT=$examId";
String upcomingExamListEndPoint = "getexams?type=upcoming";
String upcomingExamDetailsEndPoint({required int examId}) =>
    "${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.userId ?? ""}/exams?type=upcoming/$examId";

String examDetailsEndPoint({required String examCode}) =>
    "getexams?&user_id=${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.userId ?? ""}&exam_code=$examCode";
//Subscribed Exam end point
String subscribedExamEndPoint =
    "subscribe?user_id=${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.userId ?? ""}";
String subscriptionExamDetailsEndPoint({required int examId}) =>
    "${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.userId ?? ""}/subscription/$examId";
String postSubscribeExamsEndPoint = "subscription";
String subscribeExamDetailsEndPoint({required String examCode}) =>
    "getexams?&user_id=${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.userId ?? ""}&exam_code=$examCode";

//User related end point
String userDetailsEndPoint =
    "getuser?user_id=${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.userId ?? ""}";
String updateUserDetails =
    "updateuser/${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.userId ?? ""}";

//category end point
String categoryExamEndPoint = "cat_exam";
String postTransactionExamsEndPoint = "transaction";
//score history
String scorehistoryExamEndPoint =
    "get_exam_result?user_id=${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.userId ?? ""}";

String scoreCardEndPoint({required String examCode, required int resultId}) =>
    "get_exam_result?user_id=${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.userId ?? ""}&exam_code=$examCode&result_id=$resultId";

// exam submit end point
String examSubmitEndPoint() => "submit_exam";

//review question end point
String reviewQuestionListEndPoint({String? examCode, int? resultId}) =>
    "examreview?result_id=$resultId";

//article and video end point
String articleEndPoint = "/video_info";
String videoEndPoint = "/video_info";

String updateUserDetailsEndPoint =
    "updateuser/${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.userId ?? ""}";

String startExamEndPoint({required String examCode, int? resultId}) =>
    "start_exam?exam_code=$examCode&result_id=$resultId&user_id=${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.userId ?? ""}";

//Payment History
String paymentHistoryEndPoint =
    "getpayment?user_id=${IndrayaniAppGLobal.instance.loginViewModel.loginDataModel?.value?.responseBody?.userId ?? ""}";
