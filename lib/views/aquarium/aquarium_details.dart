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
  final double currentTemperature = 25.5;
  final String statusMessage = "ALL GOOD";

  void _navigateToPage(int index) {
    if (index == _selectedBottomIndex) return;

    setState(() => _selectedBottomIndex = index);

    switch (index) {
      case 0:
        // Già sulla home, non fare nulla
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ParametersPage()),
        ).then((_) => setState(() => _selectedBottomIndex = 0));
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChartsPage()),
        ).then((_) => setState(() => _selectedBottomIndex = 0));
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        ).then((_) => setState(() => _selectedBottomIndex = 0));
        break;
    }
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
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF4a4a4a), Color(0xFF3a3a3a)]), borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                    child: const Text('Check Status', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const SizedBox(height: 12),
                  Text(statusMessage, style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text('Aggiornato 5 minuti fa', style: TextStyle(color: Colors.white70, fontSize: 11)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF3a3a3a), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white12)),
              child: Row(
                children: [
                  const Icon(Icons.thermostat, color: Colors.white70, size: 20),
                  const SizedBox(width: 8),
                  const Text('Temperature', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const Spacer(),
                  Text('${currentTemperature.toStringAsFixed(1)}°C', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: const DashboardPage()),
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
      onTap: () => _navigateToPage(index),
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
