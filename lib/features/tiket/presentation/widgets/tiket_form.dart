import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class TiketForm extends StatefulWidget {
  final String jenisBus;
  final VoidCallback onBack;
  final VoidCallback onSuccess;

  const TiketForm({
    super.key,
    required this.jenisBus,
    required this.onBack,
    required this.onSuccess,
  });

  @override
  State<TiketForm> createState() => _TiketFormState();
}

class _TiketFormState extends State<TiketForm> {
  final _formKey = GlobalKey<FormState>();
  final _keberangkatanCtrl = TextEditingController();
  final _tujuanCtrl = TextEditingController();
  DateTime? _selectedDate;
  int _penumpang = 1;

  @override
  void dispose() {
    _keberangkatanCtrl.dispose();
    _tujuanCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryDark,
            onPrimary: AppColors.white,
            surface: AppColors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      widget.onSuccess();
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih tanggal perjalanan terlebih dahulu.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Flexible(
                  child: Text(
                    'Pesan Tiket ${widget.jenisBus}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton.icon(
                  onPressed: widget.onBack,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 13,
                    color: AppColors.gray400,
                  ),
                  label: const Text(
                    'Kembali',
                    style: TextStyle(color: AppColors.gray400),
                  ),
                ),
              ],
            ),
            const Divider(height: 28, color: AppColors.gray200),

            // Fields grid
            LayoutBuilder(builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              final fields = [
                _FormField(
                  label: 'Lokasi Keberangkatan',
                  hint: 'Pilih titik awal...',
                  controller: _keberangkatanCtrl,
                  prefixIcon: const Icon(
                    Icons.location_on,
                    size: 18,
                    color: AppColors.gray400,
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Wajib diisi' : null,
                ),
                _FormField(
                  label: 'Tujuan',
                  hint: 'Pilih titik tujuan...',
                  controller: _tujuanCtrl,
                  prefixIcon: const Icon(
                    Icons.my_location,
                    size: 18,
                    color: AppColors.gray400,
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Wajib diisi' : null,
                ),
              ];

              return isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: fields
                          .map((f) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: f,
                                ),
                              ))
                          .toList(),
                    )
                  : Column(
                      children: fields
                          .map((f) =>
                              Padding(padding: const EdgeInsets.only(bottom: 16), child: f))
                          .toList(),
                    );
            }),

            const SizedBox(height: 4),

            LayoutBuilder(builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              final dateField = _DateField(
                selectedDate: _selectedDate,
                onTap: _pickDate,
              );
              final penumpangField = _PenumpangDropdown(
                value: _penumpang,
                onChanged: (v) => setState(() => _penumpang = v ?? 1),
              );

              return isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: dateField,
                          ),
                        ),
                        Expanded(child: penumpangField),
                      ],
                    )
                  : Column(
                      children: [
                        dateField,
                        const SizedBox(height: 16),
                        penumpangField,
                      ],
                    );
            }),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 2,
                ),
                child: const Text(
                  'Cari Tiket & Jadwal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final Widget prefixIcon;
  final String? Function(String?) validator;

  const _FormField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.gray700,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: prefixIcon,
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const _DateField({required this.selectedDate, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tanggal Perjalanan',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.gray700,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.gray300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              selectedDate != null
                  ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                  : 'Pilih tanggal...',
              style: TextStyle(
                color: selectedDate != null ? AppColors.secondary : AppColors.gray400,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PenumpangDropdown extends StatelessWidget {
  final int value;
  final ValueChanged<int?> onChanged;

  const _PenumpangDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Jumlah Penumpang',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.gray700,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<int>(
          value: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.gray300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.gray300),
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          items: [1, 2, 3]
              .map((n) => DropdownMenuItem(
                    value: n,
                    child: Text('$n Orang'),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
