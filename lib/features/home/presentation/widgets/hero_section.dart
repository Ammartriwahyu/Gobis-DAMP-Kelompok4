import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return SizedBox(
      height: isDesktop ? 420 : 380,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Dark background
          Container(color: AppColors.secondary),
          // Background image overlay
          Opacity(
            opacity: 0.4,
            child: Image.network(
              'https://i.pinimg.com/1200x/f0/07/d9/f007d9770da93348eb38451d7cb9d06d.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppColors.secondary),
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
              fontSize: 36,
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
        Text(
          'Temukan rute tercepat, pantau jadwal bus secara real-time, dan pesan tiket perjalanan Anda dengan mudah dalam satu platform.',
          textAlign: centered ? TextAlign.center : TextAlign.left,
          style: const TextStyle(
            color: AppColors.gray300,
            fontSize: 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          spacing: 12,
          runSpacing: 12,
          children: [
            PrimaryButton(
              label: 'Pesan Tiket Sekarang',
              onPressed: () => Navigator.pushReplacementNamed(context, '/tiket'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.secondary,
                backgroundColor: AppColors.white,
                side: BorderSide.none,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                elevation: 3,
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
