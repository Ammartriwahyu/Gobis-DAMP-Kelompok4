import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_nav_bar.dart';
import '../../data/lokasi_data.dart';
import '../widgets/halte_info_sheet.dart';

class PetaPage extends StatefulWidget {
  const PetaPage({super.key});

  @override
  State<PetaPage> createState() => _PetaPageState();
}

class _PetaPageState extends State<PetaPage> {
  final MapController _mapController = MapController();
  final _locationCtrl = TextEditingController();
  bool _showRekomendasi = false;

  static const LatLng _centerSurabaya = LatLng(-7.2504, 112.7688);

  String get _jenis {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return args?['jenis'] as String? ?? 'Suroboyo Bus';
  }

  String get _target {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return args?['target'] as String? ?? 'Halte';
  }

  List<LokasiModel> get _lokasiList =>
      _target == 'Halte' ? LokasiData.halte : LokasiData.terminal;

  @override
  void dispose() {
    _locationCtrl.dispose();
    super.dispose();
  }

  void _zoomIn() => _mapController.move(
        _mapController.camera.center,
        _mapController.camera.zoom + 1,
      );

  void _zoomOut() => _mapController.move(
        _mapController.camera.center,
        _mapController.camera.zoom - 1,
      );

  void _centerMap() => _mapController.move(_centerSurabaya, 13);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavBar(currentRoute: '/'),
      endDrawer: const AppDrawer(currentRoute: '/'),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(bottom: BorderSide(color: AppColors.gray100)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title row
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: AppColors.gray600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Cari $_target - $_jenis',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Location input
                TextFormField(
                  controller: _locationCtrl,
                  decoration: InputDecoration(
                    hintText: 'Masukkan jalan atau landmark terdekat...',
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.gray400,
                    ),
                    suffixIcon: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.my_location,
                        size: 16,
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
                const SizedBox(height: 12),
                // Action buttons
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
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: _showRekomendasi
                              ? Colors.transparent
                              : AppColors.primaryLight,
                        ),
                        child: Text('Pilih $_target Sendiri'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => _showRekomendasi = true);
                          _centerMap();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Rekomendasi Terdekat',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Map
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _centerSurabaya,
                    initialZoom: 13.0,
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
                          width: 48,
                          height: 56,
                          child: GestureDetector(
                            onTap: () =>
                                HalteInfoSheet.show(context, lokasi),
                            child: Column(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
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
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      isHalte
                                          ? Icons.directions_bus
                                          : Icons.account_balance,
                                      color: AppColors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 2,
                                  height: 10,
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

                // Zoom controls
                Positioned(
                  right: 16,
                  bottom: 80,
                  child: Column(
                    children: [
                      _MapButton(
                        icon: Icons.add,
                        onTap: _zoomIn,
                      ),
                      const SizedBox(height: 8),
                      _MapButton(
                        icon: Icons.remove,
                        onTap: _zoomOut,
                      ),
                      const SizedBox(height: 8),
                      _MapButton(
                        icon: Icons.my_location,
                        onTap: _centerMap,
                      ),
                    ],
                  ),
                ),

                // Legend
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_lokasiList.length} $_target ditemukan',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Ketuk pin untuk info detail',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.gray500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: AppColors.gray700),
      ),
    );
  }
}
