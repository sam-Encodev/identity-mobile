import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class SaveContact {
  final state = signal(false);
}

class Themer {
  final state = signal(ThemeMode.system);
}

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<SaveContact>(SaveContact());
  getIt.registerSingleton<Themer>(Themer());
}
