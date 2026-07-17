/// isar_service.dart
///
/// Singleton service responsible for opening and exposing the Isar database
/// instance for the duration of the application lifecycle.
///
/// Key design choices:
///  - Opening is deferred until [IsarService.open] is first called so the
///    service can be registered with the DI container at startup without
///    blocking the main isolate.
///  - A [Completer] guards against concurrent open calls from multiple
///    callers racing during app startup.
///  - [path_provider] resolves the database directory for iOS, Android,
///    macOS, Linux, and Windows without additional conditional code.
library;

import 'dart:async';

import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'models/isar_food_item.dart';
import 'models/isar_meal_log.dart';

// ── IsarService ───────────────────────────────────────────────────────────────

/// Injectable service that manages the [Isar] database lifecycle.
///
/// ### Usage
/// Register as a lazy singleton in the DI container:
/// ```dart
/// getIt.registerLazySingleton<IsarService>(() => IsarService());
/// ```
/// Then open the database during app startup (before any repository is used):
/// ```dart
/// await getIt<IsarService>().open();
/// ```
final class IsarService {
  IsarService();

  Isar? _db;
  Completer<Isar>? _openCompleter;

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Returns the live [Isar] instance, throwing if [open] has not been called.
  Isar get db {
    if (_db == null || !_db!.isOpen) {
      throw StateError(
        'IsarService: database is not open. '
        'Call IsarService.open() before accessing db.',
      );
    }
    return _db!;
  }

  /// Returns `true` when the database is currently open and usable.
  bool get isOpen => _db?.isOpen ?? false;

  /// Opens the Isar database, registering all application schemas.
  ///
  /// Safe to call multiple times — subsequent calls return the same future
  /// without re-opening the database.
  ///
  /// [directory] overrides the automatic platform-aware path; useful in tests.
  Future<Isar> open({String? directory}) async {
    // Return immediately if already open.
    if (_db != null && _db!.isOpen) return _db!;

    // Guard concurrent open calls.
    if (_openCompleter != null) return _openCompleter!.future;

    _openCompleter = Completer<Isar>();

    try {
      final dir = directory ?? await _resolveDirectory();
      final isar = await Isar.open(
        [
          IsarFoodItemSchema,
          IsarMealLogSchema,
        ],
        directory: dir,
        name: 'fitking_db',
        // Inspector is useful during development; disable in release builds
        // via Dart define: --dart-define=ISAR_INSPECTOR=false
        inspector: const bool.fromEnvironment(
          'ISAR_INSPECTOR',
          defaultValue: false,
        ),
      );

      _db = isar;
      _openCompleter!.complete(isar);
      return isar;
    } catch (e, st) {
      _openCompleter!.completeError(e, st);
      _openCompleter = null;
      rethrow;
    }
  }

  /// Closes the database connection cleanly.
  ///
  /// Should be called when the application is about to terminate, or in
  /// integration tests between runs. Resets internal state so [open] can
  /// be called again if needed.
  Future<void> close() async {
    if (_db != null && _db!.isOpen) {
      await _db!.close();
    }
    _db = null;
    _openCompleter = null;
  }

  // ── Transaction helpers ───────────────────────────────────────────────────

  /// Convenience wrapper for a read transaction.
  Future<T> readTxn<T>(Future<T> Function(Isar isar) action) {
    return db.txn(() => action(db));
  }

  /// Convenience wrapper for a write transaction.
  Future<T> writeTxn<T>(Future<T> Function(Isar isar) action) {
    return db.writeTxn(() => action(db));
  }

  // ── Private ────────────────────────────────────────────────────────────────

  /// Resolves the platform-appropriate directory path for database storage.
  ///
  /// - iOS / Android → application documents directory (sandboxed, persisted)
  /// - macOS / Windows / Linux → application support directory
  static Future<String> _resolveDirectory() async {
    // getApplicationDocumentsDirectory works on all supported platforms.
    final appDir = await getApplicationDocumentsDirectory();
    return appDir.path;
  }
}
