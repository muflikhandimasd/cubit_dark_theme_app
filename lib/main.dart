import 'dart:ui';

import 'package:cubit_dark_theme_app/cubit/theme/theme_cubit.dart';
import 'package:cubit_dark_theme_app/theme/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await ThemeDBService.checkDBExists();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                useMaterial3: true,
                primarySwatch: Colors.brown,
                brightness:
                    state.isLightTheme ? Brightness.light : Brightness.dark),
            home: const MyAppView(),
          );
        },
      ),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dark Theme Cubit'),
      ),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<ThemeCubit>().lightMode();
                      ThemeDBService.putThemeSettings(true);
                    },
                    child: Text(
                      'LIGHT',
                      style: TextStyle(
                          color:
                              state.isLightTheme ? Colors.black : Colors.white),
                    )),
                ElevatedButton(
                    onPressed: () {
                      context.read<ThemeCubit>().darkMode();
                      ThemeDBService.putThemeSettings(false);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            state.isLightTheme ? Colors.black : Colors.white),
                    child: Text(
                      'DARK',
                      style: TextStyle(
                          color:
                              state.isLightTheme ? Colors.white : Colors.black),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
