import 'package:latlong2/latlong.dart';

class LokasiModel {
  final String nama;
  final String tipe;
  final String rute;
  final LatLng koordinat;
  final String keterangan;

  const LokasiModel({
    required this.nama,
    required this.tipe,
    required this.rute,
    required this.koordinat,
    required this.keterangan,
  });
}

class LokasiData {
  LokasiData._();

  static const List<LokasiModel> halte = [
    LokasiModel(
      nama: 'Halte Basuki Rahmat',
      tipe: 'Halte',
      rute: 'SB R1',
      koordinat: LatLng(-7.2619, 112.7405),
      keterangan: 'Beroperasi 06:00 - 21:00 WIB',
    ),
    LokasiModel(
      nama: 'Halte Darmo',
      tipe: 'Halte',
      rute: 'SB R1',
      koordinat: LatLng(-7.2854, 112.7303),
      keterangan: 'Beroperasi 06:00 - 21:00 WIB',
    ),
    LokasiModel(
      nama: 'Halte Taman Surya',
      tipe: 'Halte',
      rute: 'SB R1',
      koordinat: LatLng(-7.2573, 112.7351),
      keterangan: 'Beroperasi 06:00 - 21:00 WIB',
    ),
    LokasiModel(
      nama: 'Halte Rajawali',
      tipe: 'Halte',
      rute: 'SB R1',
      koordinat: LatLng(-7.2325, 112.7333),
      keterangan: 'Beroperasi 06:00 - 21:00 WIB',
    ),
    LokasiModel(
      nama: 'Halte Wonokromo',
      tipe: 'Halte',
      rute: 'SB R2',
      koordinat: LatLng(-7.3089, 112.7365),
      keterangan: 'Beroperasi 06:00 - 21:00 WIB',
    ),
    LokasiModel(
      nama: 'Halte ITS Sukolilo',
      tipe: 'Halte',
      rute: 'TSS',
      koordinat: LatLng(-7.2758, 112.7964),
      keterangan: 'Beroperasi 05:30 - 20:30 WIB',
    ),
    LokasiModel(
      nama: 'Halte UNESA Lidah Wetan',
      tipe: 'Halte',
      rute: 'TSS',
      koordinat: LatLng(-7.3128, 112.7268),
      keterangan: 'Beroperasi 05:30 - 20:30 WIB',
    ),
  ];

  static const List<LokasiModel> terminal = [
    LokasiModel(
      nama: 'Terminal Purabaya',
      tipe: 'Terminal',
      rute: 'Bus AKDP / AKAP',
      koordinat: LatLng(-7.3562, 112.7386),
      keterangan: 'Terminal terbesar di Surabaya, beroperasi 24 jam',
    ),
    LokasiModel(
      nama: 'Terminal Tambak Osowilangon',
      tipe: 'Terminal',
      rute: 'Bus Kota Utara',
      koordinat: LatLng(-7.1842, 112.7116),
      keterangan: 'Beroperasi 05:00 - 22:00 WIB',
    ),
    LokasiModel(
      nama: 'Terminal Joyoboyo',
      tipe: 'Terminal',
      rute: 'Bus Kota / Angkot',
      koordinat: LatLng(-7.2987, 112.7407),
      keterangan: 'Beroperasi 05:00 - 22:00 WIB',
    ),
  ];
}
