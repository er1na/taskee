import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'l10n/gen_l10n/app_text.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/task_list_screen.dart';
import 'screens/task_create_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TASKee',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF5B67CA)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FF),
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'NotoSansJP'),
      ),

      localizationsDelegates: const [
        AppText.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppText.supportedLocales,

      initialRoute: '/',
      routes: {
        '/': (context) => const TaskListScreen(),
        '/create': (context) => const TaskCreateScreen(),
      },
    );
  }
}
