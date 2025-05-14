import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/network_info.dart';
import 'package:pulsedevice/core/global_controller.dart';

class ApiService {
  final Dio _dio;
  static final NetworkInfo _networkInfo = NetworkInfo();

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: Api.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          contentType: Headers.jsonContentType,
        )) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 自動加入 Bearer token
          final token = Get.find<GlobalController>().apiToken.value;
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          print('----[API REQUEST]-------------------');
          print('URL: ${options.method} ${options.uri}');
          print('Headers: ${options.headers}');
          print('Body: ${options.data}');
          print('-------------------------------------');

          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('----[API RESPONSE]------------------');
          print('URL: ${response.realUri}');
          print('Status: ${response.statusCode}');
          print('Data: ${response.data}');
          print('-------------------------------------');

          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('----[API ERROR]---------------------');
          print('Error: ${e.message}');
          print('URL: ${e.requestOptions.uri}');
          print('-------------------------------------');

          return handler.next(e);
        },
      ),
    );
  }

  /// 發送 POST 請求，回傳 JSON Map
  Future<Map<String, dynamic>> postJson(
    String path,
    Map<String, dynamic> data,
  ) async {
    final hasConnection = await _networkInfo.isConnected();
    if (!hasConnection) throw NoInternetException('請確認網路連線');

    try {
      final response = await _dio.post(path, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          return response.data;
        } else {
          throw Exception('回應非 JSON 格式');
        }
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      throw Exception('Dio 錯誤：${e.message}');
    }
  }
}
