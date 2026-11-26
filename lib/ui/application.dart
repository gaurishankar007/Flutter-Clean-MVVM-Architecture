import 'package:clean_architecture/config/app_config.dart';
import 'package:clean_architecture/domain/models/app_theme_mode.dart';
import 'package:clean_architecture/routing/routes.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/providers/screen_type/screen_type_notifier.dart';
import 'package:clean_architecture/ui/core/providers/session/session_notifier.dart';
import 'package:clean_architecture/ui/core/providers/settings/app_settings_notifier.dart';
import 'package:clean_architecture/ui/core/themes/theme_data.dart';
import 'package:clean_architecture/ui/core/utils/frame_callback.dart';
import 'package:clean_architecture/ui/core/utils/toast_util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Root widget: router, themes, breakpoint tracking and session expiry.
class const CleanArchitectureApp({super.key}) extends ConsumerStatefulWidget {
  @override
  ConsumerState<CleanArchitectureApp> createState() =>
      _CleanArchitectureAppState();
}

class _CleanArchitectureAppState extends ConsumerState<CleanArchitectureApp>
    with WidgetsBindingObserver {
  final _router = AppRouter();
  final _lightTheme = buildTheme(.light);
  final _darkTheme = buildTheme(.dark);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _router.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() => runAfterBuild(() {
    if (mounted) {
      ref.read(screenTypeProvider.notifier).update();
    }
  });

  @override
  Widget build(BuildContext context) {
    // An expired session (refresh failed) sends the user to login.
    ref.listen(sessionProvider, (previous, next) {
      if (next.expired && previous?.expired != true) {
        final navigatorContext = _router.navigatorKey.currentContext;
        if (navigatorContext != null) {
          ToastUtil.showStateMessage(navigatorContext, next.message);
        }
        _router.replaceAll([const LoginRoute()]);
      }
    });
    final themeMode = ref.watch(
      appSettingsProvider.select((state) => state.settings.themeMode),
    );
    return MaterialApp.router(
      title: AppConfigUtil.I.appTitle,
      debugShowCheckedModeBanner: false,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: switch (themeMode) {
        AppThemeMode.system => ThemeMode.system,
        AppThemeMode.dark => ThemeMode.dark,
        AppThemeMode.light => ThemeMode.light,
      },
      routerConfig: _router.config(),
    );
  }
}
