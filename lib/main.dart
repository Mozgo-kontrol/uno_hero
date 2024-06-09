import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uno_notes/presantation/home_page/widgets/home_page.dart';
import 'package:uno_notes/theme.dart';
import 'application/home_page/home_bloc.dart';
import 'injection.dart' as di;
import 'injection.dart';
GetIt getIt = GetIt.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Uno Hero',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home:
      BlocProvider(
          create: (BuildContext context) => sl<HomeBloc>(),
          child: const Homepage()
      ),

    );
  }
}
