import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum ButtonVariant { filled, outline }

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final bool fullWidth;
  final double verticalPadding;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ButtonVariant.filled,
    this.fullWidth = false,
    this.verticalPadding = 14,
  });

  @override
  Widget build(BuildContext context) {
    final child = Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    );

    final button = variant == ButtonVariant.filled
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.secondary,
              shape: const StadiumBorder(),
              elevation: 3,
              padding: EdgeInsets.symmetric(
                horizontal: 32,
                vertical: verticalPadding,
              ),
            ),
            child: child,
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.secondary,
              side: const BorderSide(color: AppColors.white, width: 1.5),
              backgroundColor: AppColors.white,
              shape: const StadiumBorder(),
              padding: EdgeInsets.symmetric(
                horizontal: 32,
                vertical: verticalPadding,
              ),
            ),
            child: child,
          );

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}
