import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class JadwalOperasionalTab extends StatelessWidget {
  const JadwalOperasionalTab({super.key});

  static const _jadwalList = [
    (
      nama: 'Suroboyo Bus (Rute R1/R2)',
      rute: 'Terminal Purabaya - Rajawali',
      jam: '06:00 - 21:00 WIB',
      keterangan: 'Setiap Hari',
    ),
    (
      nama: 'Trans Semanggi Suroboyo',
      rute: 'UNESA - ITS',
      jam: '05:30 - 20:30 WIB',
      keterangan: 'Setiap Hari',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    if (isDesktop) {
      return Row(
        children: _jadwalList
            .map((j) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _JadwalCard(
                      nama: j.nama,
                      rute: j.rute,
                      jam: j.jam,
                      keterangan: j.keterangan,
                    ),
                  ),
                ))
            .toList(),
      );
    }

    return Column(
      children: _jadwalList
          .map((j) => _JadwalCard(
                nama: j.nama,
                rute: j.rute,
                jam: j.jam,
                keterangan: j.keterangan,
              ))
          .toList(),
    );
  }
}

class _JadwalCard extends StatelessWidget {
  final String nama;
  final String rute;
  final String jam;
  final String keterangan;

  const _JadwalCard({
    required this.nama,
    required this.rute,
    required this.jam,
    required this.keterangan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  rute,
                  style: const TextStyle(
                    color: AppColors.gray500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                jam,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.green600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                keterangan,
                style: const TextStyle(
                  color: AppColors.gray400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
