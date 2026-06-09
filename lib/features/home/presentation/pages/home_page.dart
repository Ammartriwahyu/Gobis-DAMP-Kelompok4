import 'package:flutter/material.dart';
import '../../../../core/widgets/app_footer.dart';
import '../../../../core/widgets/app_nav_bar.dart';
import '../widgets/cara_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/layanan_section.dart';
import '../widgets/tentang_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavBar(currentRoute: '/'),
      endDrawer: const AppDrawer(currentRoute: '/'),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HeroSection(),
            LayananSection(),
            CaraSection(),
            TentangSection(),
            AppFooter(),
          ],
        ),
      ),
    );
  }
}
