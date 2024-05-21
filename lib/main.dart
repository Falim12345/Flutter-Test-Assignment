import 'package:flutter/material.dart';
import 'package:flutter_application_6/repo/test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

import 'presentation/bloc/app_cubit.dart';
import 'presentation/pages/home_page.dart';
import 'repo/data_base_rep.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); // Инициализация сервиса уведомлений
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuildingCubit(DatabaseRepository()),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
