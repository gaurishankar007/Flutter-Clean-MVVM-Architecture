import 'package:clean_architecture/config/app_config.dart';
import 'package:clean_architecture/ui/startup/run_clean_architecture_app.dart';

Future<void> main() => runCleanArchitectureApp(environment: Flavor.staging);
