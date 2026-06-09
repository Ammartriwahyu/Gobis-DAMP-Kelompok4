import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/lokasi_data.dart';

class PetaModal extends StatefulWidget {
  final String jenis;
  final String target;

  const PetaModal({super.key, required this.jenis, required this.target});

  static void show(
    BuildContext context, {
    required String jenis,
    required String target,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => PetaModal(jenis: jenis, target: target),
    );
  }

  @override
  State<PetaModal> createState() => _PetaModalState();
}

class _PetaModalState extends State<PetaModal> {
  final MapController _mapController = MapController();
  final _locationCtrl = TextEditingController();
  bool _showRekomendasi = false;

  static const LatLng _centerSurabaya = LatLng(-7.2504, 112.7688);

  List<LokasiModel> get _lokasiList =>
      widget.target == 'Halte' ? LokasiData.halte : LokasiData.terminal;

  @override
  void dispose() {
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dialogContext = context;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge,
      elevation: 24,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 768),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header — bg-gray-50 px-6 py-4 border-b
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColors.gray50,
                border: Border(bottom: BorderSide(color: AppColors.gray100)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cari ${widget.target} - ${widget.jenis}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.gray400,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),

            // Body — p-6
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Location label + input
                    const Text(
                      'Lokasi Anda Saat Ini',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _locationCtrl,
                      decoration: InputDecoration(
                        hintText: 'Masukkan jalan atau landmark terdekat...',
                        suffixIcon: TextButton.icon(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.locationCrosshairs,
                            size: 13,
                            color: AppColors.primaryDark,
                          ),
                          label: const Text(
                            'Deteksi',
                            style: TextStyle(
                              color: AppColors.primaryDark,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Two action buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () =>
                                setState(() => _showRekomendasi = false),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primaryDark,
                              side: const BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              backgroundColor: _showRekomendasi
                                  ? Colors.transparent
                                  : AppColors.primaryLight,
                            ),
                            child: Text('Pilih ${widget.target} Sendiri'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                setState(() => _showRekomendasi = true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: const Text(
                              'Rekomendasi Terdekat',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Interactive map area
                    SizedBox(
                      height: 256,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FlutterMap(
                          mapController: _mapController,
                          options: const MapOptions(
                            initialCenter: _centerSurabaya,
                            initialZoom: 12.0,
                            minZoom: 10.0,
                            maxZoom: 18.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.kelompok4.gobis',
                            ),
                            MarkerLayer(
                              markers: _lokasiList.map((lokasi) {
                                final isHalte = lokasi.tipe == 'Halte';
                                return Marker(
                                  point: lokasi.koordinat,
                                  width: 40,
                                  height: 48,
                                  child: GestureDetector(
                                    onTap: () {
                                      final nav = Navigator.of(dialogContext);
                                      nav.pop();
                                      nav.pushNamed(
                                        '/peta',
                                        arguments: {
                                          'jenis': widget.jenis,
                                          'target': widget.target,
                                        },
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: isHalte
                                                ? AppColors.primaryDark
                                                : AppColors.sky600,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppColors.white,
                                              width: 2,
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x44000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: FaIcon(
                                              isHalte
                                                  ? FontAwesomeIcons.bus
                                                  : FontAwesomeIcons
                                                      .buildingColumns,
                                              color: AppColors.white,
                                              size: 13,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 2,
                                          height: 8,
                                          color: isHalte
                                              ? AppColors.primaryDark
                                              : AppColors.sky600,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_lokasiList.length} ${widget.target} ditemukan · Ketuk pin untuk info detail',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.gray500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
