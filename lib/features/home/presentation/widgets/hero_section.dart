import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onLihatLayanan;

  const HeroSection({super.key, this.onLihatLayanan});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return SizedBox(
      height: isDesktop ? 440 : 400,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Dark background
          Container(color: AppColors.secondary),
          // Background image at 40% opacity — same URL as HTML
          Opacity(
            opacity: 0.4,
            child: Image.network(
              'https://i.pinimg.com/1200x/f0/07/d9/f007d9770da93348eb38451d7cb9d06d.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 48 : 24,
              vertical: 48,
            ),
            child: isDesktop
                ? _heroContent(context)
                : Center(child: _heroContent(context, centered: true)),
          ),
        ],
      ),
    );
  }

  Widget _heroContent(BuildContext context, {bool centered = false}) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          textAlign: centered ? TextAlign.center : TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              height: 1.25,
            ),
            children: [
              TextSpan(text: 'Solusi Mobilitas\n'),
              TextSpan(
                text: 'Kota Surabaya',
                style: TextStyle(color: AppColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 672),
          child: Text(
            'Temukan rute tercepat, pantau jadwal bus secara real-time, dan pesan tiket perjalanan Anda dengan mudah dalam satu platform.',
            textAlign: centered ? TextAlign.center : TextAlign.left,
            style: const TextStyle(
              color: AppColors.gray300,
              fontSize: 16,
              height: 1.65,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/tiket'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.secondary,
                shape: const StadiumBorder(),
                elevation: 4,
                shadowColor: Colors.black38,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              child: const Text(
                'Pesan Tiket Sekarang',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            ElevatedButton(
              onPressed: onLihatLayanan,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.secondary,
                shape: const StadiumBorder(),
                elevation: 4,
                shadowColor: Colors.black38,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              child: const Text(
                'Lihat Layanan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
