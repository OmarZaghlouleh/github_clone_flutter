import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/data/data_resource/local_resource/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../links.dart';
import 'dio_errors_handler.dart';

class BaseApiClient {
  static Dio client = Dio();
  static const String _acceptHeader = 'application/json';

  static Map<String, dynamic> defaultHeaders = {
    'accept': _acceptHeader,
    'x-api-key':
        "2dyJLjdiqyJ9c5qKYGjmPAkdkaxa93vO2UtP8V9tQDt4X3mUdQVfkCqd5Ju3Q65X",
  };

  BaseApiClient() {
    client.interceptors.add(LogInterceptor());
    if (kDebugMode) {
      client.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        request: true,
      ));
    }
    client.options.baseUrl = Links.baseUrl;
  }

  static Future<Either<String, T>> post<T>(
      {required String url,
      Map<String, dynamic>? headers,
      dynamic formData,
      Map<String, dynamic>? queryParameters,
      ResponseType? responseTypeValue,
      required Function(dynamic) converter,
      Function(String)? saveToken,
      dynamic returnOnError}) async {
    try {
      var response = await client.post(
        url,
        queryParameters: queryParameters,
        data: formData,
        onSendProgress: (int sent, int total) {
          if (kDebugMode) {
            print(
                'progress: ${(sent / total * 100).toStringAsFixed(0)}% ($sent/$total)');
          }
        },
        options: Options(
          headers: headers ?? defaultHeaders,
          responseType: responseTypeValue ?? ResponseType.json,
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! <= 205) {
        if (kDebugMode) {
          print(response.data);
        }
        if (saveToken != null) {
          saveToken(response.headers['Authorization']!.first);
        }
        return right(converter(response.data));
      } else {
        return left(response.data['message']);
      }
    } on DioException catch (e) {
      Map dioError = DioErrorsHandler.onError(e);

      if (kDebugMode) {
        print(e);
      }
      if (responseTypeValue == ResponseType.bytes) {
        if (e.response?.statusCode == 413) {
          return left("The selected item is empty");
        } else if (e.response?.statusCode == 404) {
          return left("The selected item not found");
        } else if (e.response?.statusCode == 500) {
          return left("Failed to create the zip file.");
        } else {
          return left("Bad request");
        }
      }
      return left(
          returnOnError ?? e.response?.data['message'] ?? dioError['message']);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(e.toString());
    }
  }

  static Future<Either<String, T>> put<T>(
      {required String url,
      dynamic formData,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      required Function(dynamic) converter,
      dynamic returnOnError}) async {
    try {
      if (LocalResource.sharedPreferences.getString('token') != null) {
        client.options.headers.addAll({
          'Authorization':
              "Bearer ${LocalResource.sharedPreferences.getString('token')}",
        });
      }
      var response = await client.put(
        url,
        data: formData,
        queryParameters: queryParameters,
        onSendProgress: (int sent, int total) {
          if (kDebugMode) {
            print(
                'progress: ${(sent / total * 100).toStringAsFixed(0)}% ($sent/$total)');
          }
        },
        options: Options(
          headers: headers ?? defaultHeaders,
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! <= 205) {
        if (kDebugMode) {
          print(response.data);
        }
      }
      return Right(converter(response.data));
    } on DioException catch (e) {
      Map dioError = DioErrorsHandler.onError(e);

      if (kDebugMode) {
        print(e);
      }
      return Left(e.response?.data['message'] ?? dioError['message']);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(e.toString());
    }
  }

  static Future<Either<String, T>> get<T>(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      ResponseType? responseTypeValue,
      required Function(dynamic) converter}) async {
    try {
      if (LocalResource.sharedPreferences.getString('token') != null) {
        client.options.headers.addAll({
          'Authorization':
              "Bearer ${LocalResource.sharedPreferences.getString('token')}",
        });
      }
      var response = await client.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers ?? defaultHeaders,
          responseType: responseTypeValue ?? ResponseType.json,
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 205) {
        if (kDebugMode) {
          print(response.data);
        }
        return Right(converter(response.data));
      } else {
        dprint(response.data);
        return left(response.data['message']);
      }
    } on DioException catch (e) {
      Map dioError = DioErrorsHandler.onError(e);

      if (kDebugMode) {
        print(e);
      }
      if (responseTypeValue == ResponseType.bytes) {
        if (e.response?.statusCode == 413) {
          return left("This group has no files yet");
        } else if (e.response?.statusCode == 404) {
          return left("The selected item not found");
        } else if (e.response?.statusCode == 500) {
          return left("Failed to create the zip file.");
        } else {
          return left("Bad request");
        }
      }

      return left(e.response?.data['message'] ?? dioError['message']);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      return left(e.toString());
    }
  }

  static Future<Either<String, T>> delete<T>(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      required Function(dynamic) converter}) async {
    try {
      if (LocalResource.sharedPreferences.getString('token') != null) {
        client.options.headers.addAll({
          'Authorization':
              "Bearer ${LocalResource.sharedPreferences.getString('token')}",
        });
      }
      // Add Token
      // MapEntry<String, dynamic> token = MapEntry('authorization',
      //     'Bearer ${LocalResource.sharedPreferences.getString('token') ?? ""}');
      // headers == null
      //     ? defaultHeaders.addEntries([token])
      //     : headers.addEntries([token]);
      var response = await client.delete(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers ?? defaultHeaders,
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! <= 205) {
        if (kDebugMode) {
          print(response.data);
        }
        return Right(converter(response.data));
      } else {
        return left(response.data['message']);
      }
    } on DioException catch (e) {
      Map dioError = DioErrorsHandler.onError(e);
      if (kDebugMode) {
        print(e);
      }
      return left(e.response?.data['message'] ?? dioError['message']);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(e.toString());
    }
  }
}
