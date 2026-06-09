import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_colors.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.secondary,
        border: Border(top: BorderSide(color: Color(0xFF374151), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [_brandInfo(), _socialLinks()],
                )
              : Column(
                  children: [
                    _brandInfo(),
                    const SizedBox(height: 16),
                    _socialLinks(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _brandInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
            children: [
              TextSpan(text: 'Go '),
              TextSpan(
                text: 'Bis',
                style: TextStyle(color: AppColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Sistem Informasi DAMP - Kelompok 4',
          style: TextStyle(color: AppColors.gray400, fontSize: 13),
        ),
      ],
    );
  }

  Widget _socialLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon(FontAwesomeIcons.instagram),
        const SizedBox(width: 16),
        _socialIcon(FontAwesomeIcons.xTwitter),
        const SizedBox(width: 16),
        _socialIcon(FontAwesomeIcons.envelope),
      ],
    );
  }

  Widget _socialIcon(FaIconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: FaIcon(icon, color: AppColors.gray400, size: 20),
      ),
    );
  }
}
