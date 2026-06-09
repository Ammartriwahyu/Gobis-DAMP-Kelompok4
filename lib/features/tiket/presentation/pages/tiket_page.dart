import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_footer.dart';
import '../../../../core/widgets/app_nav_bar.dart';
import '../widgets/tiket_form.dart';
import '../widgets/tiket_selection.dart';

class TiketPage extends StatefulWidget {
  const TiketPage({super.key});

  @override
  State<TiketPage> createState() => _TiketPageState();
}

class _TiketPageState extends State<TiketPage> {
  String? _selectedJenis;

  void _showToast() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.emerald500,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: AppColors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pesanan Diterima!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Pencarian jadwal & tiket berhasil dikonfirmasi.',
                    style: TextStyle(color: AppColors.gray400, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(16),
      ),
    );
    setState(() => _selectedJenis = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavBar(currentRoute: '/tiket'),
      endDrawer: const AppDrawer(currentRoute: '/tiket'),
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
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryLight,
                        border: Border(
                          bottom: BorderSide(color: AppColors.gray100),
                        ),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Pesan Tiket Perjalanan',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Beli tiket lebih awal untuk kenyamanan perjalanan Anda.',
                            style: TextStyle(color: AppColors.gray600, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 896),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: _selectedJenis == null
                                ? TiketSelection(
                                    key: const ValueKey('selection'),
                                    onSelect: (jenis) =>
                                        setState(() => _selectedJenis = jenis),
                                  )
                                : TiketForm(
                                    key: const ValueKey('form'),
                                    jenisBus: _selectedJenis!,
                                    onBack: () => setState(() => _selectedJenis = null),
                                    onSuccess: _showToast,
                                  ),
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
