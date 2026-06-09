import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/jadwal/presentation/pages/jadwal_page.dart';
import 'features/peta/presentation/pages/peta_page.dart';
import 'features/tiket/presentation/pages/tiket_page.dart';

class GoBisApp extends StatelessWidget {
  const GoBisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Bis Surabaya',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/jadwal': (_) => const JadwalPage(),
        '/tiket': (_) => const TiketPage(),
        '/login': (_) => const LoginPage(),
        '/peta': (_) => const PetaPage(),
      },
    );
  }
}
