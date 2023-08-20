import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_assignment/Api/ConfigUrl.dart';
import 'package:news_assignment/dailogs.dart';


class DioConfig {

  static BaseOptions options = BaseOptions(
    baseUrl: ConfigUrl.baseUrl,
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 15000),
  );

  static final Dio _dio = Dio(options);

  static get dio => _dio;
}


class Result {
  Response? response;
  DioException? dioError;
  Result({this.response,this.dioError});

  void handleError(BuildContext context) {
    print("url to be called ===${response?.realUri}");
    if(dioError != null) {
      final error = dioError!.error;
      print("error == ${error}");
      if(error is SocketException) {
        Dialogs.errorDialog(context, 'Failed to connect to MCP servers.');
      } else if(error is TimeoutException) {
        Dialogs.errorDialog(context, 'Request timed out. Try again.');
      } else if(dioError!.response != null && dioError!.response!.data is Map) {
        final errMsg = dioError!.response?.data['error']['message'];

        print("ERR MSG: $errMsg");

        if(errMsg != null) {
          // ignore: use_build_context_synchronously
          Dialogs.errorDialog(context, '$errMsg');
        } else {
          // ignore: use_build_context_synchronously
          Dialogs.errorDialog(context, 'There was a problem. Try again.');
        }
      }
    }
  }
}