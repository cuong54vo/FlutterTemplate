import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:childcaresoftware/constants/api.dart';
import 'package:childcaresoftware/models/models.dart';
import 'package:childcaresoftware/services/remote/dio_provider.dart';

class NetworkService {
  final Dio _dio = DioProvider.instance();
  String? _token;

  NetworkService._privateConstructor();

  static final NetworkService _instance = NetworkService._privateConstructor();

  static NetworkService get instance => _instance;

  Map<String, dynamic> baseHeader() {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (_token != null) {
      headers["Authorization"] = _token!;
    }
    return headers;
  }

  void setToken(String token) {
    _token = token;
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? data}) async {
    data ??= {};
    _prepareRequestData(data);
    try {
      final response = await _dio.post(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: baseHeader()),
      );
      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters}) async {
    queryParameters ??= {};
    _prepareRequestParameters(queryParameters);
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: baseHeader()),
      );
      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> put(String url, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? data}) async {
    data ??= {};
    _prepareRequestData(data);
    try {
      final response = await _dio.put(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: baseHeader()),
      );
      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> delete(String url, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? data}) async {
    data ??= {};
    _prepareRequestData(data);
    try {
      final response = await _dio.delete(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: baseHeader()),
      );
      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleError(e);
    }
  }

  void _prepareRequestData(Map<String, dynamic> data) {
    data['mws_db_server'] = API.MWS_DB_SERVER;
    data['cur_acc_id'] = API.CURRENT_ACCOUNT_ID;
    data['api_version'] = API.API_VERSION;
    data['platform'] = Platform.isAndroid ? 'android' : 'ios';
    data['token'] = API.TOKEN;
  }

  void _prepareRequestParameters(Map<String, dynamic> queryParameters) {
    queryParameters['mws_db_server'] = API.MWS_DB_SERVER;
    queryParameters['cur_acc_id'] = API.CURRENT_ACCOUNT_ID;
    queryParameters['api_version'] = API.API_VERSION;
    queryParameters['platform'] = Platform.isAndroid ? 'android' : 'ios';
    queryParameters['token'] = API.TOKEN;
  }

  dynamic _handleResponse(Response response) {
    final dataResponse = DataResponse.fromJson(response.data);
    if (dataResponse.success == true) {
      return dataResponse.payload;
    }
    // Use a fallback value if message is null
    throw APIException(error: dataResponse.message ?? 'An unknown error occurred.');
  }

  Future<dynamic> _handleError(DioError e) async {
    if (e.response != null) {
      final errorList = e.response?.data['errors'] ?? [];
      final errorMessage = errorList.isNotEmpty ? errorList[0] : 'An error occurred. Please try again!';
      throw APIException(error: errorMessage);
    } else {
      print(e.requestOptions);
      print(e.message);
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        throw APIException(error: 'The network is not available. Please check your connection and try again.');
      } else {
        throw APIException(error: 'An error occurred. Please try again!');
      }
    }
  }
}
