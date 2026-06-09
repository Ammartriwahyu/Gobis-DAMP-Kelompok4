import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/lokasi_data.dart';

class HalteInfoSheet extends StatelessWidget {
  final LokasiModel lokasi;

  const HalteInfoSheet({super.key, required this.lokasi});

  static void show(BuildContext context, LokasiModel lokasi) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => HalteInfoSheet(lokasi: lokasi),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isHalte = lokasi.tipe == 'Halte';

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.gray300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Icon + name
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isHalte ? AppColors.primaryLight : AppColors.sky100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: FaIcon(
                    isHalte ? FontAwesomeIcons.bus : FontAwesomeIcons.buildingColumns,
                    color: isHalte ? AppColors.primaryDark : AppColors.sky600,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lokasi.nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.secondary,
                      ),
                    ),
                    Text(
                      lokasi.tipe,
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

          const SizedBox(height: 16),
          const Divider(color: AppColors.gray100),
          const SizedBox(height: 12),

          // Route
          _infoRow(
            icon: FontAwesomeIcons.route,
            label: 'Rute',
            value: lokasi.rute,
          ),
          const SizedBox(height: 8),
          _infoRow(
            icon: FontAwesomeIcons.clock,
            label: 'Operasional',
            value: lokasi.keterangan,
          ),
          const SizedBox(height: 20),

          // Close button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.secondary,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Tutup',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(icon, size: 13, color: AppColors.primaryDark),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.gray600,
            fontSize: 13,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: AppColors.secondary, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
