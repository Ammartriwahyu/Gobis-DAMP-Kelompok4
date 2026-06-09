import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';

class JadwalPemberhentianTab extends StatefulWidget {
  const JadwalPemberhentianTab({super.key});

  @override
  State<JadwalPemberhentianTab> createState() => _JadwalPemberhentianTabState();
}

class _JadwalPemberhentianTabState extends State<JadwalPemberhentianTab> {
  final _controller = TextEditingController();
  String _query = '';

  static const _halteList = [
    (
      nama: 'Halte Basuki Rahmat',
      rute: 'SB R1',
      estimasi: '10:15 WIB (5 mnt lagi)',
      status: 'ontime',
    ),
    (
      nama: 'Halte Darmo',
      rute: 'SB R1',
      estimasi: '10:25 WIB (15 mnt lagi)',
      status: 'padat',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 640;
    final filtered = _halteList
        .where((h) => h.nama.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Container(
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Cari nama halte...',
                      prefixIcon: Icon(Icons.search, color: AppColors.gray400),
                    ),
                    onChanged: (v) => setState(() => _query = v),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.magnifyingGlass, size: 14),
                  label: const Text('Cari'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.gray100),
          if (isMobile)
            ...filtered.map((h) => _HalteCard(halte: h))
          else ...[
            Container(
              color: AppColors.gray50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Nama Halte',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Rute',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Est. Bus Berikutnya',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.gray200),
            ...filtered.map((h) => _HalteRow(halte: h)),
          ],
        ],
      ),
    );
  }
}

class _HalteCard extends StatelessWidget {
  final ({String nama, String rute, String estimasi, String status}) halte;

  const _HalteCard({required this.halte});

  @override
  Widget build(BuildContext context) {
    final isOnTime = halte.status == 'ontime';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      halte.nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            halte.rute,
                            style: const TextStyle(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            isOnTime
                                ? const _PulseCircle()
                                : const Icon(
                                    Icons.warning_amber_rounded,
                                    color: AppColors.yellow600,
                                    size: 12,
                                  ),
                            const SizedBox(width: 4),
                            Text(
                              isOnTime ? 'On Time' : 'Padat Merayap',
                              style: TextStyle(
                                color: isOnTime
                                    ? AppColors.green600
                                    : AppColors.yellow600,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      halte.estimasi,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.gray500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.gray100),
      ],
    );
  }
}

class _HalteRow extends StatelessWidget {
  final ({String nama, String rute, String estimasi, String status}) halte;

  const _HalteRow({required this.halte});

  @override
  Widget build(BuildContext context) {
    final isOnTime = halte.status == 'ontime';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  halte.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.secondary,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    halte.rute,
                    style: const TextStyle(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  halte.estimasi,
                  style: const TextStyle(fontSize: 13, color: AppColors.secondary),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    isOnTime
                        ? const _PulseCircle()
                        : const Icon(
                            Icons.warning_amber_rounded,
                            color: AppColors.yellow600,
                            size: 12,
                          ),
                    const SizedBox(width: 4),
                    Text(
                      isOnTime ? 'On Time' : 'Padat Merayap',
                      style: TextStyle(
                        color: isOnTime ? AppColors.green600 : AppColors.yellow600,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.gray100),
      ],
    );
  }
}

class _PulseCircle extends StatefulWidget {
  const _PulseCircle();

  @override
  State<_PulseCircle> createState() => _PulseCircleState();
}

class _PulseCircleState extends State<_PulseCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, child) => Opacity(
        opacity: _anim.value,
        child: child,
      ),
      child: const Icon(Icons.circle, color: AppColors.green600, size: 10),
    );
  }
}
