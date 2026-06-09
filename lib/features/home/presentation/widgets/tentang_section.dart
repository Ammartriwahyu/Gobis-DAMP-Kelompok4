import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class TentangSection extends StatelessWidget {
  const TentangSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 768;
    final isMobile = width < 480;

    return Container(
      color: AppColors.light,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 48 : 64,
        horizontal: isMobile ? 16 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.gray100,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: EdgeInsets.all(isMobile ? 20 : 32),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: _busImage()),
                      const SizedBox(width: 40),
                      Expanded(child: _textContent()),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _busImage(),
                      const SizedBox(height: 24),
                      _textContent(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _busImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?q=80&w=2069&auto=format&fit=crop',
        height: 256,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: 256,
          decoration: BoxDecoration(
            color: AppColors.gray300,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Icon(Icons.directions_bus, size: 64, color: AppColors.gray500),
          ),
        ),
      ),
    );
  }

  Widget _textContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tentang Go Bis Surabaya',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Go Bis merupakan platform digital interaktif yang dirancang untuk memudahkan masyarakat dan wisatawan di Kota Surabaya dalam menggunakan fasilitas transportasi umum.',
          style: TextStyle(
            color: AppColors.gray600,
            fontSize: 14,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Mendukung Sustainable Development Goals (SDG\'s) ke-11: Sustainable Cities and Communities, kami hadir untuk mengurai kemacetan dan menciptakan mobilitas perkotaan yang efisien dan ramah lingkungan.',
          style: TextStyle(
            color: AppColors.gray600,
            fontSize: 14,
            height: 1.7,
          ),
        ),
      ],
    );
  }
}
