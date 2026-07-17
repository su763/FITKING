/// dio_client.dart
///
/// Configured Dio HTTP client wrapper for the FitKing data layer.
///
/// [DioClient] is a thin facade over a [Dio] instance. It:
///  - Reads base configuration from [AppConfig] (URL, timeouts, API key).
///  - Attaches a structured logging interceptor (dev / staging only).
///  - Injects the FDC API key on every outgoing request.
///  - Normalises raw [DioException]s into typed domain [Failure]s via
///    [DioErrorMapper.toFailure].
library;

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../core/config/app_config.dart';
import '../../core/errors/failures.dart';

// ── DioClient ────────────────────────────────────────────────────────────────

/// Injectable Dio wrapper used exclusively by data-source classes.
///
/// Obtain via the DI container:
/// ```dart
/// final client = getIt<DioClient>();
/// final response = await client.get('/foods/search', params: {...});
/// ```
final class DioClient {
  DioClient(AppConfig config)
      : _config = config,
        _dio = _buildDio(config);

  final AppConfig _config;
  final Dio _dio;

  /// Low-level access to the underlying [Dio] instance for advanced usage.
  Dio get raw => _dio;

  // ── Public HTTP helpers ──────────────────────────────────────────────────

  /// Issues a GET request to [path] relative to [AppConfig.foodApiBaseUrl].
  ///
  /// [queryParameters] are appended to the URL as query strings.
  /// The API key is automatically added by the auth interceptor.
  ///
  /// Throws a typed [Failure] subtype on error — never a raw exception.
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e, st) {
      throw DioErrorMapper.toFailure(e, st);
    }
  }

  /// Issues a POST request to [path] with a JSON [data] body.
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e, st) {
      throw DioErrorMapper.toFailure(e, st);
    }
  }

  // ── Factory ───────────────────────────────────────────────────────────────

  static Dio _buildDio(AppConfig config) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.foodApiBaseUrl,
        connectTimeout: Duration(milliseconds: config.connectTimeoutMs),
        receiveTimeout: Duration(milliseconds: config.receiveTimeoutMs),
        sendTimeout: Duration(milliseconds: config.connectTimeoutMs),
        responseType: ResponseType.json,
        contentType: 'application/json',
        headers: const {
          'Accept': 'application/json',
        },
      ),
    );

    // Inject API key on every request.
    dio.interceptors.add(_ApiKeyInterceptor(config.foodApiKey));

    // Verbose logging in non-production environments.
    if (config.enableNetworkLogs) {
      dio.interceptors.add(_StructuredLogInterceptor());
    }

    return dio;
  }
}

// ── API Key Interceptor ───────────────────────────────────────────────────────

/// Appends the `api_key` query parameter to every outgoing request.
///
/// Using a query-parameter rather than a header matches the USDA FDC API spec.
final class _ApiKeyInterceptor extends Interceptor {
  const _ApiKeyInterceptor(this._apiKey);

  final String _apiKey;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.putIfAbsent('api_key', () => _apiKey);
    handler.next(options);
  }
}

// ── Structured Log Interceptor ────────────────────────────────────────────────

final class _StructuredLogInterceptor extends Interceptor {
  final Logger _log = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log.i(
      '➡ ${options.method} ${options.uri}\n'
      'Headers: ${options.headers}\n'
      'Body: ${options.data}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    _log.i(
      '✅ ${response.statusCode} ${response.requestOptions.uri}\n'
      'Data length: ${response.data.toString().length} chars',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log.e(
      '❌ ${err.type.name} ${err.requestOptions.uri}\n'
      'Message: ${err.message}\n'
      'Response: ${err.response?.data}',
      error: err,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }
}

// ── DioErrorMapper ────────────────────────────────────────────────────────────

/// Converts a [DioException] into the appropriate domain [Failure] subtype.
///
/// All callers in the data layer should use this mapper rather than catching
/// raw exceptions, ensuring the domain layer never sees Dio internals.
abstract final class DioErrorMapper {
  const DioErrorMapper._();

  /// Maps [exception] to the most specific [Failure] subtype available.
  static Failure toFailure(DioException exception, StackTrace stackTrace) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        TimeoutFailure(stackTrace: stackTrace),

      DioExceptionType.connectionError =>
        NoInternetFailure(stackTrace: stackTrace),

      DioExceptionType.badResponse => _mapBadResponse(exception, stackTrace),

      DioExceptionType.cancel =>
        InvalidOperationFailure(
          message: 'Request was cancelled.',
          stackTrace: stackTrace,
        ),

      _ => UnexpectedFailure(
          message: exception.message ?? 'Unknown network error.',
          stackTrace: stackTrace,
          originalException: exception,
        ),
    };
  }

  static Failure _mapBadResponse(
    DioException exception,
    StackTrace stackTrace,
  ) {
    final statusCode = exception.response?.statusCode;
    final body = exception.response?.data?.toString();

    return switch (statusCode) {
      400 => ValidationFailure(
          message: 'Bad request: ${body ?? "Invalid parameters."}',
          stackTrace: stackTrace,
        ),
      401 || 403 => ServerFailure(
          message: 'Authentication failed. Check your API key.',
          code: 'AUTH_ERROR',
          statusCode: statusCode,
          stackTrace: stackTrace,
        ),
      404 => CacheNotFoundFailure(
          message: 'Resource not found on remote server.',
          stackTrace: stackTrace,
        ),
      429 => ServerFailure(
          message: 'API rate limit exceeded. Please wait and retry.',
          code: 'RATE_LIMITED',
          statusCode: 429,
          stackTrace: stackTrace,
        ),
      int s when s >= 500 => ServerFailure(
          message: 'Server error ($s). Please try again later.',
          statusCode: s,
          responseBody: body,
          stackTrace: stackTrace,
        ),
      _ => ServerFailure(
          message: 'Unexpected HTTP response ($statusCode).',
          statusCode: statusCode,
          responseBody: body,
          stackTrace: stackTrace,
        ),
    };
  }
}
