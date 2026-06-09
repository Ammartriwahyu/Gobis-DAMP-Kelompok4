import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_colors.dart';

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentRoute;

  const AppNavBar({super.key, required this.currentRoute});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 2,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _Logo(),
            const Spacer(),
            if (isDesktop) ...[
              _NavLink(label: 'Beranda', route: '/', currentRoute: currentRoute),
              const SizedBox(width: 4),
              _NavLink(
                label: 'Jadwal Transportasi',
                route: '/jadwal',
                currentRoute: currentRoute,
              ),
              const SizedBox(width: 4),
              _NavLink(
                label: 'Pesan Tiket',
                route: '/tiket',
                currentRoute: currentRoute,
              ),
              const SizedBox(width: 16),
              _LoginButton(),
            ] else ...[
              Builder(
                builder: (ctx) => IconButton(
                  onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                  icon: const FaIcon(
                    FontAwesomeIcons.bars,
                    color: AppColors.gray600,
                    size: 20,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, '/'),
      child: Row(
        children: [
          const FaIcon(
            FontAwesomeIcons.bus,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
              children: [
                TextSpan(text: 'Go '),
                TextSpan(
                  text: 'Bis',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final String route;
  final String currentRoute;

  const _NavLink({
    required this.label,
    required this.route,
    required this.currentRoute,
  });

  bool get _isActive => currentRoute == route;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (!_isActive) Navigator.pushReplacementNamed(context, route);
      },
      style: TextButton.styleFrom(
        foregroundColor:
            _isActive ? AppColors.primaryDark : AppColors.gray600,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _isActive ? AppColors.primaryDark : AppColors.gray600,
          fontWeight:
              _isActive ? FontWeight.bold : FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, '/login'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.secondary,
        shape: const StadiumBorder(),
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: const Text(
        'Masuk / Daftar',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _drawerItem(context, 'Beranda', '/'),
              _drawerItem(context, 'Jadwal Transportasi', '/jadwal'),
              _drawerItem(context, 'Pesan Tiket', '/tiket'),
              const Divider(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.secondary,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Masuk / Daftar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String label, String route) {
    final isActive = currentRoute == route;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      title: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.primaryDark : AppColors.gray600,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          fontSize: 15,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        if (!isActive) Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}
