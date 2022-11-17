import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_library/internal/application.dart';
import 'package:local_library/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all application dependencies
  await initializeDependencies();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  // Run application
  runApp(const LibraryApp());
}
