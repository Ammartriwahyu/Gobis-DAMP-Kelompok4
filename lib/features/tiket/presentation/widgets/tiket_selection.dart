import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';

class TiketSelection extends StatelessWidget {
  final ValueChanged<String> onSelect;

  const TiketSelection({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return Column(
      children: [
        const Text(
          'Pilih Layanan',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
          ),
        ),
        const SizedBox(height: 24),
        if (isDesktop)
          Row(
            children: [
              Expanded(
                child: _TiketCard(
                  jenis: 'Suroboyo Bus',
                  subtitle: 'Perjalanan dalam kota (QRIS / Poin Sampah)',
                  icon: FontAwesomeIcons.ticket,
                  iconBg: AppColors.primaryLight,
                  iconColor: AppColors.primaryDark,
                  borderHoverColor: AppColors.primary,
                  onTap: () => onSelect('Suroboyo Bus'),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _TiketCard(
                  jenis: 'Bus Kota / AKDP',
                  subtitle: 'Perjalanan antar kota / terminal',
                  icon: FontAwesomeIcons.busSimple,
                  iconBg: AppColors.sky50,
                  iconColor: AppColors.sky600,
                  borderHoverColor: AppColors.sky400,
                  onTap: () => onSelect('Bus Kota'),
                ),
              ),
            ],
          )
        else
          Column(
            children: [
              _TiketCard(
                jenis: 'Suroboyo Bus',
                subtitle: 'Perjalanan dalam kota (QRIS / Poin Sampah)',
                icon: FontAwesomeIcons.ticket,
                iconBg: AppColors.primaryLight,
                iconColor: AppColors.primaryDark,
                borderHoverColor: AppColors.primary,
                onTap: () => onSelect('Suroboyo Bus'),
              ),
              const SizedBox(height: 16),
              _TiketCard(
                jenis: 'Bus Kota / AKDP',
                subtitle: 'Perjalanan antar kota / terminal',
                icon: FontAwesomeIcons.busSimple,
                iconBg: AppColors.sky50,
                iconColor: AppColors.sky600,
                borderHoverColor: AppColors.sky400,
                onTap: () => onSelect('Bus Kota'),
              ),
            ],
          ),
      ],
    );
  }
}

class _TiketCard extends StatefulWidget {
  final String jenis;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final Color borderHoverColor;
  final VoidCallback onTap;

  const _TiketCard({
    required this.jenis,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.borderHoverColor,
    required this.onTap,
  });

  @override
  State<_TiketCard> createState() => _TiketCardState();
}

class _TiketCardState extends State<_TiketCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovering ? widget.borderHoverColor : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: _hovering ? widget.iconBg : widget.iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: FaIcon(
                    widget.icon,
                    color: widget.iconColor,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tiket ${widget.jenis}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                        color: AppColors.gray500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
