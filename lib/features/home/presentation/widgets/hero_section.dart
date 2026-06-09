import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onLihatLayanan;

  const HeroSection({super.key, this.onLihatLayanan});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 768;
    final isMobile = width < 480;

    return SizedBox(
      height: isDesktop ? 440 : (isMobile ? 420 : 400),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: AppColors.secondary),
          Opacity(
            opacity: 0.4,
            child: Image.network(
              'https://i.pinimg.com/1200x/f0/07/d9/f007d9770da93348eb38451d7cb9d06d.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 48 : 24,
              vertical: 48,
            ),
            child: isDesktop
                ? _heroContent(context, isMobile: false)
                : Center(child: _heroContent(context, centered: true, isMobile: isMobile)),
          ),
        ],
      ),
    );
  }

  Widget _heroContent(BuildContext context, {bool centered = false, bool isMobile = false}) {
    final titleSize = isMobile ? 26.0 : 38.0;
    final bodySize = isMobile ? 14.0 : 16.0;

    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          textAlign: centered ? TextAlign.center : TextAlign.left,
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              height: 1.25,
            ),
            children: const [
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
            style: TextStyle(
              color: AppColors.gray300,
              fontSize: bodySize,
              height: 1.65,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          spacing: 12,
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
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 32,
                  vertical: 14,
                ),
              ),
              child: Text(
                'Pesan Tiket Sekarang',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 14 : 15,
                ),
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
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 32,
                  vertical: 14,
                ),
              ),
              child: Text(
                'Lihat Layanan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 14 : 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
