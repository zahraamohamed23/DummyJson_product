import 'package:flutter/material.dart';
import 'package:products_dummyjson/core/config/di.dart';

class DependencyInjection {
  static Future<void>init ()
  async {
    WidgetsFlutterBinding.ensureInitialized();
    await initDi ();
  }
}

