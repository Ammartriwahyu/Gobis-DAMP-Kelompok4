import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';

class LayananSection extends StatelessWidget {
  const LayananSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return Container(
      color: AppColors.light,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              const Text(
                'Layanan Transportasi',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pilih moda transportasi yang sesuai dengan tujuan Anda.',
                style: TextStyle(color: AppColors.gray500, fontSize: 14),
              ),
              const SizedBox(height: 40),
              if (isDesktop)
                Row(
                  children: [
                    Expanded(child: _LayananCard(
                      jenis: 'Suroboyo Bus',
                      target: 'Halte',
                      description: 'Layanan bus di dalam kota Surabaya. Cari dan temukan halte terdekat dari lokasi Anda saat ini.',
                      icon: FontAwesomeIcons.bus,
                      iconBg: AppColors.primaryLight,
                      iconColor: AppColors.primaryDark,
                    )),
                    const SizedBox(width: 24),
                    Expanded(child: _LayananCard(
                      jenis: 'Bus Kota',
                      target: 'Terminal',
                      description: 'Layanan bus untuk jangkauan yang lebih luas. Cari dan temukan terminal pemberangkatan terdekat.',
                      icon: FontAwesomeIcons.busSimple,
                      iconBg: AppColors.sky100,
                      iconColor: AppColors.sky600,
                    )),
                  ],
                )
              else
                Column(
                  children: [
                    _LayananCard(
                      jenis: 'Suroboyo Bus',
                      target: 'Halte',
                      description: 'Layanan bus di dalam kota Surabaya. Cari dan temukan halte terdekat dari lokasi Anda saat ini.',
                      icon: FontAwesomeIcons.bus,
                      iconBg: AppColors.primaryLight,
                      iconColor: AppColors.primaryDark,
                    ),
                    const SizedBox(height: 16),
                    _LayananCard(
                      jenis: 'Bus Kota',
                      target: 'Terminal',
                      description: 'Layanan bus untuk jangkauan yang lebih luas. Cari dan temukan terminal pemberangkatan terdekat.',
                      icon: FontAwesomeIcons.busSimple,
                      iconBg: AppColors.sky100,
                      iconColor: AppColors.sky600,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LayananCard extends StatefulWidget {
  final String jenis;
  final String target;
  final String description;
  final FaIconData icon;
  final Color iconBg;
  final Color iconColor;

  const _LayananCard({
    required this.jenis,
    required this.target,
    required this.description,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });

  @override
  State<_LayananCard> createState() => _LayananCardState();
}

class _LayananCardState extends State<_LayananCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          '/peta',
          arguments: {'jenis': widget.jenis, 'target': widget.target},
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.gray100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_hovering ? 0.12 : 0.06),
                blurRadius: _hovering ? 20 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              AnimatedScale(
                scale: _hovering ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: widget.iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: FaIcon(widget.icon, color: widget.iconColor, size: 30),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.jenis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.gray500,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
