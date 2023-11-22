import "package:dio/dio.dart";
import "package:github_clone_flutter/data/data_resource/local_resource/shared_preferences.dart";

class ClientInterceptor extends Interceptor {
  @override
  void onRequest(options, handler) {
    options.headers = {
      // "Accept-Language": DataStore.instance.lang,
      // "Content-Type": Headers.jsonContentType,
      // "Content-Type":"text/html",
      "token": LocalResource.sharedPreferences.getString('token') ?? "",
      // "Accept": Headers.jsonContentType,
      "Accept": '*/*',
      // "AcceptApplication/json": Headers.jsonContentType,
    };
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data == "error") {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: response.data["msg"] ?? response.data["message"],
          type: DioExceptionType.badResponse,
        ),
      );
    } else {
      handler.resolve(response);
    }
  }
}
