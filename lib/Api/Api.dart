import 'package:dio/dio.dart';
import 'package:news_assignment/Api/Dio.dart';


class DioApi {

   static String token = "";

  static Future<Result> post(
      {required String path,
      required dynamic data,
      Duration? sendTimeout,
      Duration? recvTimeout}) async {
    
    try {
      Response response = await DioConfig.dio.request(
        path,
        data: data,
        options: Options(
          sendTimeout: sendTimeout,
          receiveTimeout: recvTimeout,
          headers: {'x-access-token': token},
          method: 'POST',
        ),
      );
      DioException? err;
      return Result(response: response, dioError: err);
    } on DioException catch (e) {
      Response? response;
      return Result(response: response, dioError: e);
    }
  }

  static Future<Result> get(
      {required String path,
      dynamic data,
      Duration? sendTimeout,
      Duration? recvTimeout}) async {

    print("token ===  $token");

    try {
      Response response = await DioConfig.dio.request(
        path,
        data: data,
        options: Options(
          sendTimeout: sendTimeout,
          receiveTimeout: recvTimeout,
          headers: {'x-access-token': token},
          method: 'GET',
        ),
      );
      DioException? err;
      return Result(response: response, dioError: err);
    } on DioException catch (e) {
      Response? response;
      return Result(response: response, dioError: e);
    }
  }

  static Future<Result> delete(
      {required String path,
      Duration? sendTimeout,
      Duration? recvTimeout}) async {
    try {
      Response response = await DioConfig.dio.request(
        path,
        options: Options(
          sendTimeout: sendTimeout,
          receiveTimeout: recvTimeout,
          method: 'DELETE',
        ),
      );
      DioException? err;
      return Result(response: response, dioError: err);
    } on DioException catch (e) {
      Response? response;
      return Result(response: response, dioError: e);
    }
  }

  static Future<Result> put(
      {required String path,
      dynamic data,
      Duration? sendTimeout,
      Duration? recvTimeout}) async {
    try {
      
      print("id Status $token");
      Response response = await DioConfig.dio.request(
        path,
        data: data,
        options: Options(
          sendTimeout: sendTimeout,
          headers: {'x-access-token': token},
          receiveTimeout: recvTimeout,
          method: 'PUT',
        ),
      );
      DioException? err;
      return Result(response: response, dioError: err);
    } on DioException catch (e) {
      Response? response;
      return Result(response: response, dioError: e);
    }
  }

  static Future<Result> patch(
      {required String path,
      Duration? sendTimeout,
      Duration? recvTimeout}) async {
    try {
      Response response = await DioConfig.dio.request(
        path,
        options: Options(
          sendTimeout: sendTimeout,
          receiveTimeout: recvTimeout,
          method: 'PATCH',
        ),
      );
      DioException? err;
      return Result(response: response, dioError: err);
    } on DioException catch (e) {
      Response? response;
      return Result(response: response, dioError: e);
    }
  }

}
