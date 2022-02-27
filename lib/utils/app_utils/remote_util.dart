import 'dart:io';

import 'package:dio/dio.dart';
import 'package:symfonia_task/utils/app_utils/locator.dart';
import '../../models/server_error_model.dart';
import '../../models/state.dart';
import 'connectivity_service.dart';

class Remote {
  late Dio dio;
  Remote(String url) {
    final options = BaseOptions(
      baseUrl: url,
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000, // 60 seconds
    );

    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(onRequest: (
      options,
      handler,
    ) async {
      //no internet? reject request
      if (!await locator<ConnectivityService>().hasInternet()) {
        handler.reject(
          DioError(
            requestOptions: options,
            error:
                "Oops! Looks like you're not connected to the internet. Check your internet connection and try again.",
          ),
        );
      }
      handler.next(options);
    }));
  }

  Future<Response> get(String url) async {
    return await dio.get(url);
  }

  static Future<State> makeRequest(
    Future<Response> future, {
    bool isStatusCode = true,
    int statusCodeSuccess = 200,
    required State Function(dynamic data) successResponse,
    required State Function(Response data) errorResponse,
    State Function(Response? data)? dioErrorResponse,
  }) async {
    try {
      return await _makeRequest(future, isStatusCode, statusCodeSuccess,
          successResponse, errorResponse);
    } on SocketException {
      return State<ServerErrorModel>.error(
        const ServerErrorModel(
            statusCode: 400,
            errorMessage: "Something went wrong "
                "please check your internet connection and try again",
            data: null),
      );
    } on DioError catch (e) {
      return State<ServerErrorModel>.error(
        ServerErrorModel(
            statusCode: 400,
            errorMessage:
                e.response?.data ?? "Something went wrong please try again",
            data: e.response?.data),
      );
    } catch (error) {
      return State<ServerErrorModel>.error(
        const ServerErrorModel(
            statusCode: 400,
            errorMessage: "Something went wrong please try again",
            data: null),
      );
    }
  }

  static Future<State> _makeRequest(
      Future<Response> future,
      bool isStatusCode,
      int statusCodeSuccess,
      State Function(dynamic data) successResponse,
      State Function(Response data) errorResponse) async {
    var req = await future;

    var response = req.data;

    if (isStatusCode) {
      return _handleResponseBasedOnStatusCode(
          response, statusCodeSuccess, successResponse, errorResponse);
    } else {
      return _handleResponseBasedOnDataReturned(
          response, successResponse, errorResponse);
    }
  }

  static State _handleResponseBasedOnStatusCode(
      Response response,
      int statusCodeSuccess,
      State Function(dynamic data) successResponse,
      State Function(Response data) errorResponse) {
    if (response.statusCode == statusCodeSuccess) {
      return successResponse(response.data);
    } else {
      return errorResponse(response);
    }
  }

  static State _handleResponseBasedOnDataReturned(
      Response response,
      State Function(dynamic data) successResponse,
      State Function(Response data) errorResponse) {
    if (response.data['status'] == 'success') {
      return successResponse(response.data);
    }
    return errorResponse(response);
  }
}
