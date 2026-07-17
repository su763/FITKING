/// main.dart
///
/// FitKing application entry point.
///
/// Responsibilities:
///  1. Initialise the Isar database via [IsarService].
///  2. Bootstrap GetIt dependency injection graph.
///  3. Select the correct [AppConfig] based on compile-time --dart-define.
///  4. Wrap the widget tree with [ResponsiveBreakpoints], BLoC providers,
///     and a Material 3 theme that supports dark / light mode.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'src/core/config/app_config.dart';
import 'src/domain/repositories/tracker_repository.dart';
import 'src/domain/usecases/calculate_daily_macros.dart';
import 'src/presentation/state/tracker_bloc.dart';
import 'src/presentation/views/home_dashboard.dart';
import 'src/services/api/dio_client.dart';
import 'src/services/database/isar_service.dart';
import 'src/services/repositories_impl/tracker_repository_impl.dart';

// ── DI container ──────────────────────────────────────────────────────────────

final _getIt = GetIt.instance;

// ── Entry point ───────────────────────────────────────────────────────────────

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait on phones; allow all orientations on tablets/desktop.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // 1. Resolve environment config from compile-time defines.
  //    Build with: flutter run --dart-define=ENV=production
  final env = const String.fromEnvironment('ENV', defaultValue: 'development');
  final appConfig = switch (env) {
    'production' => AppConfig.production(),
    'staging' => AppConfig.staging(),
    _ => AppConfig.development(),
  };

  // 2. Open the Isar database before the DI graph is built.
  final isarService = IsarService();
  await isarService.open();

  // 3. Register the DI graph.
  _setupDependencies(appConfig, isarService);

  // 4. Launch the app.
  runApp(const FitKingApp());
}

void _setupDependencies(AppConfig config, IsarService isarService) {
  // Core config
  _getIt.registerSingleton<AppConfig>(config);

  // Infrastructure
  _getIt.registerSingleton<IsarService>(isarService);
  _getIt.registerLazySingleton<DioClient>(() => DioClient(_getIt<AppConfig>()));

  // Repository
  _getIt.registerLazySingleton<TrackerRepository>(
    () => TrackerRepositoryImpl(
      isarService: _getIt<IsarService>(),
      dioClient: _getIt<DioClient>(),
    ),
  );

  // Use cases
  _getIt.registerLazySingleton<CalculateDailyMacros>(
    () => CalculateDailyMacros(_getIt<TrackerRepository>()),
  );
}

// ── Root App Widget ───────────────────────────────────────────────────────────

class FitKingApp extends StatelessWidget {
  const FitKingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TrackerBloc>(
          create: (_) => TrackerBloc(
            repository: _getIt<TrackerRepository>(),
            calculateDailyMacros: _getIt<CalculateDailyMacros>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'FitKing',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: _buildTheme(Brightness.light),
        darkTheme: _buildTheme(Brightness.dark),
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: const [
            Breakpoint(start: 0, end: 479, name: MOBILE),
            Breakpoint(start: 480, end: 899, name: TABLET),
            Breakpoint(start: 900, end: 1279, name: DESKTOP),
            Breakpoint(start: 1280, end: double.infinity, name: '4K'),
          ],
        ),
        home: const HomeDashboard(),
      ),
    );
  }

  // ── Theme ────────────────────────────────────────────────────────────────

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6C63FF),
      brightness: brightness,
      primary: const Color(0xFF6C63FF),
      secondary: const Color(0xFF00C896),
      tertiary: const Color(0xFFFFB547),
      error: const Color(0xFFFF6B6B),
      surface: isDark ? const Color(0xFF121218) : const Color(0xFFF8F7FF),
      onSurface: isDark ? const Color(0xFFF0EFF8) : const Color(0xFF1A1840),
      surfaceContainerLow: isDark
          ? const Color(0xFF1C1B2E)
          : const Color(0xFFFFFFFF),
      surfaceContainerHighest: isDark
          ? const Color(0xFF252438)
          : const Color(0xFFECEBFF),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,
      fontFamily: 'Inter',

      // AppBar
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
      ),

      // Cards
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outlineVariant.withOpacity(0.3),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),

      // Chips
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        labelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Input fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // FAB
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Bottom sheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        showDragHandle: false,
        clipBehavior: Clip.antiAlias,
      ),

      // Text
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 26,
          fontWeight: FontWeight.w700,
          height: 1.25,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
