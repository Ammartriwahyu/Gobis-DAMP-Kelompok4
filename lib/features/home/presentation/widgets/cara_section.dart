import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';

class CaraSection extends StatelessWidget {
  const CaraSection({super.key});

  static const _steps = [
    (
      icon: FontAwesomeIcons.locationDot,
      title: '1. Pilih Lokasi',
      desc: 'Tentukan lokasi awal dan tujuan perjalanan Anda.'
    ),
    (
      icon: FontAwesomeIcons.route,
      title: '2. Cek Rute & Jadwal',
      desc: 'Lihat rute yang tersedia dan pantau jadwal bus.'
    ),
    (
      icon: FontAwesomeIcons.ticket,
      title: '3. Pesan Tiket',
      desc: 'Lakukan pemesanan tiket secara digital dengan mudah.'
    ),
    (
      icon: FontAwesomeIcons.bus,
      title: '4. Selamat Menikmati',
      desc: 'Naik bus dari halte/terminal dan nikmati perjalanan.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              const Text(
                'Cara Menggunakan Go Bis',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 40),
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _steps
                      .map((s) => Expanded(child: _StepItem(step: s)))
                      .toList(),
                )
              else
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.85,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: _steps.map((s) => _StepItem(step: s)).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final ({IconData icon, String title, String desc}) step;

  const _StepItem({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          FaIcon(step.icon, color: AppColors.primaryDark, size: 36),
          const SizedBox(height: 12),
          Text(
            step.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            step.desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.gray500,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
