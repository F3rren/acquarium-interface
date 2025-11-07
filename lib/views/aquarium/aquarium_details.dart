import 'package:acquariumfe/views/dashboard/dashboard_page.dart';
import 'package:acquariumfe/views/parameters/parameters_page.dart';
import 'package:acquariumfe/views/parameters/charts_page.dart';
import 'package:acquariumfe/views/profile/profile_page.dart';
import 'package:flutter/material.dart';

class AquariumDetails extends StatefulWidget {
  const AquariumDetails({super.key});

  @override
  State<StatefulWidget> createState() => _AquariumDetailsState();
}

class _AquariumDetailsState extends State<AquariumDetails> {
  int _selectedBottomIndex = 0;

  // Lista delle pagine da mostrare
  final List<Widget> _pages = const [
    DashboardPage(),
    ParametersPage(),
    ChartsPage(),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedBottomIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2d2d2d),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: const BoxDecoration(color: Color(0xFF3a3a3a)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: () {}),
                  const Text('La Mia Vasca', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                  IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: _selectedBottomIndex,
                children: _pages,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: const Color(0xFF3a3a3a), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: const Offset(0, -2))]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.dashboard, 'Dashboard', 0),
                _buildNavItem(Icons.science, 'Parametri', 1),
                _buildNavItem(Icons.show_chart, 'Grafici', 2),
                _buildNavItem(Icons.person, 'Profilo', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedBottomIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: isSelected ? const Color(0xFF60a5fa).withValues(alpha: 0.2) : Colors.transparent, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF60a5fa) : Colors.white60, size: 24),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: isSelected ? const Color(0xFF60a5fa) : Colors.white60, fontSize: 10, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}
