// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:wanFlutter/page/common/Api.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class NetWorkUtil {
  static late NetWorkUtil instace;
  late Dio dio;
  late BaseOptions options;

  CancelToken cancelToken = CancelToken();

  static NetWorkUtil getInstace() {
    if (instace == null) instace = NetWorkUtil();
    return instace;
  }

  NetWorkUtil() {
    options = BaseOptions(
        baseUrl: Api.BASE_URL,
        connectTimeout: 3000,
        receiveTimeout: 5000,
        headers: {"version": "1.0.0"},
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.plain);

    dio = Dio(options);

    dio.interceptors.add(CookieManager(CookieJar()));

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print("");
      return options;
    }, onResponse: (response) {
      print("object");
      return response;
    }, onError: (DioError e) {
      print("error");
      return e;
    }));
  }

  get(url, {data, options, cancelToken}) async {
    late Response response;
    try {
      response = await dio.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      print("resopnse:$response");
    } on DioError catch (e) {
      print("get error$e");
      //抛出
    }
    return response;
  }

  post(url, {data, options, cancalToken}) async {
    late Response response;
    try {
      response = await dio.post(url,
          queryParameters: data, options: options, cancelToken: cancalToken);
      print("post success $data");
    } on DioError catch (e) {
      print("post error $e");
    }

    return response;
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    late Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
    }
    return response.data;
  }
}
