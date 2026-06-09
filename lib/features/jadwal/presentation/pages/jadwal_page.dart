import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_footer.dart';
import '../../../../core/widgets/app_nav_bar.dart';
import '../widgets/jadwal_operasional_tab.dart';
import '../widgets/jadwal_pemberhentian_tab.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavBar(currentRoute: '/jadwal'),
      endDrawer: const AppDrawer(currentRoute: '/jadwal'),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Hero
                    Container(
                      color: AppColors.secondary,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
                      child: const Column(
                        children: [
                          Text(
                            'Informasi Jadwal Transportasi',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Pantau waktu operasional dan estimasi kedatangan armada kami.',
                            style: TextStyle(color: AppColors.gray300, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              // Tab navigation
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: AppColors.gray200),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _TabButton(
                                      label: 'Jadwal Operasional',
                                      isActive: _tabIndex == 0,
                                      onTap: () => setState(() => _tabIndex = 0),
                                    ),
                                    _TabButton(
                                      label: 'Pemberhentian & Keberangkatan',
                                      isActive: _tabIndex == 1,
                                      onTap: () => setState(() => _tabIndex = 1),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Tab content
                              if (_tabIndex == 0)
                                const JadwalOperasionalTab()
                              else
                                const JadwalPemberhentianTab(),
                            ],
                          ),
                        ),
                      ),
                    ),
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

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.primaryDark : AppColors.gray500,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
