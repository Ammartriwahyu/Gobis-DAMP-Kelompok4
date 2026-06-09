import 'package:flutter/material.dart';
import '../../../../core/widgets/app_footer.dart';
import '../../../../core/widgets/app_nav_bar.dart';
import '../widgets/cara_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/layanan_section.dart';
import '../widgets/tentang_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _layananKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToLayanan() {
    final ctx = _layananKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavBar(currentRoute: '/'),
      endDrawer: const AppDrawer(currentRoute: '/'),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeroSection(onLihatLayanan: _scrollToLayanan),
                    LayananSection(key: _layananKey),
                    const CaraSection(),
                    const TentangSection(),
                    const Spacer(),
                    const AppFooter(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
