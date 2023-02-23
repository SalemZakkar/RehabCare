import 'dart:io';

import 'package:dio/dio.dart';

import 'web_services_export.dart';

Dio myDio = Dio();

class WebConnection {
  WebConnection() {
    myDio = Dio(
      BaseOptions(
        connectTimeout: 12000,
        receiveTimeout: 12000,
        sendTimeout: 12000,
        headers: {
          "Accept": "*/*",
          "Connection": "keep-alive",
        },
        baseUrl: EndPoints.baseUrl,
        responseType: ResponseType.plain,
      ),
    );
    myDio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        responseHeader: true,
        requestHeader: true,
        request: true,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  MyHttpOverrides();

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
