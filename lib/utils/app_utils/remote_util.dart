import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:symfonia_task/utils/app_utils/locator.dart';
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
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
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
}
