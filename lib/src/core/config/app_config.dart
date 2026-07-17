/// app_config.dart
///
/// Centralised, environment-aware configuration for the FitKing app.
/// Instantiate once via dependency injection and inject wherever required.
library;

enum AppEnvironment { development, staging, production }

/// Immutable snapshot of all runtime configuration values.
///
/// Usage (via GetIt after DI setup):
/// ```dart
/// final config = getIt<AppConfig>();
/// print(config.foodApiBaseUrl);
/// ```
final class AppConfig {
  AppConfig._({
    required this.environment,
    required this.foodApiBaseUrl,
    required this.foodApiKey,
    required this.connectTimeoutMs,
    required this.receiveTimeoutMs,
    required this.enableNetworkLogs,
    required this.enableAnalytics,
    required this.hiveBoxNames,
  });

  // ── Factory constructors per environment ────────────────────────────────

  factory AppConfig.development() => AppConfig._(
        environment: AppEnvironment.development,
        foodApiBaseUrl: 'https://api.nal.usda.gov/fdc/v1',
        foodApiKey: const String.fromEnvironment(
          'FOOD_API_KEY_DEV',
          defaultValue: 'DEMO_KEY',
        ),
        connectTimeoutMs: 10000,
        receiveTimeoutMs: 15000,
        enableNetworkLogs: true,
        enableAnalytics: false,
        hiveBoxNames: HiveBoxNames.defaults(),
      );

  factory AppConfig.staging() => AppConfig._(
        environment: AppEnvironment.staging,
        foodApiBaseUrl: 'https://api.nal.usda.gov/fdc/v1',
        foodApiKey: const String.fromEnvironment(
          'FOOD_API_KEY_STAGING',
          defaultValue: '',
        ),
        connectTimeoutMs: 8000,
        receiveTimeoutMs: 12000,
        enableNetworkLogs: true,
        enableAnalytics: true,
        hiveBoxNames: HiveBoxNames.defaults(),
      );

  factory AppConfig.production() => AppConfig._(
        environment: AppEnvironment.production,
        foodApiBaseUrl: 'https://api.nal.usda.gov/fdc/v1',
        foodApiKey: const String.fromEnvironment(
          'FOOD_API_KEY_PROD',
          defaultValue: '',
        ),
        connectTimeoutMs: 6000,
        receiveTimeoutMs: 10000,
        enableNetworkLogs: false,
        enableAnalytics: true,
        hiveBoxNames: HiveBoxNames.defaults(),
      );

  // ── Fields ──────────────────────────────────────────────────────────────

  final AppEnvironment environment;

  /// Base URL for the USDA FoodData Central API (or any compatible endpoint).
  final String foodApiBaseUrl;

  /// API key injected at build time via `--dart-define`.
  final String foodApiKey;

  /// HTTP connect timeout in milliseconds.
  final int connectTimeoutMs;

  /// HTTP receive timeout in milliseconds.
  final int receiveTimeoutMs;

  /// Whether to enable verbose Dio network logging.
  final bool enableNetworkLogs;

  /// Whether to report analytics events (disable in dev to avoid noise).
  final bool enableAnalytics;

  /// Hive box name constants for type-safe access.
  final HiveBoxNames hiveBoxNames;

  // ── Derived helpers ──────────────────────────────────────────────────────

  bool get isProduction => environment == AppEnvironment.production;
  bool get isDevelopment => environment == AppEnvironment.development;
  bool get isStaging => environment == AppEnvironment.staging;

  @override
  String toString() =>
      'AppConfig(env: $environment, baseUrl: $foodApiBaseUrl, '
      'networkLogs: $enableNetworkLogs, analytics: $enableAnalytics)';
}

// ── Hive Box Names ──────────────────────────────────────────────────────────

/// Strongly-typed constants for all Hive box names used across the app.
/// Prevents typo-related runtime errors.
final class HiveBoxNames {
  HiveBoxNames._({
    required this.mealLogs,
    required this.foodItems,
    required this.userProfile,
    required this.dailyGoals,
    required this.settings,
  });

  factory HiveBoxNames.defaults() => HiveBoxNames._(
        mealLogs: 'meal_logs_box',
        foodItems: 'food_items_box',
        userProfile: 'user_profile_box',
        dailyGoals: 'daily_goals_box',
        settings: 'settings_box',
      );

  final String mealLogs;
  final String foodItems;
  final String userProfile;
  final String dailyGoals;
  final String settings;
}
