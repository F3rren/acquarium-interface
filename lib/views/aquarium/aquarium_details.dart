import 'package:acquariumfe/routes/routes_name.dart';
import 'package:flutter/material.dart';

class AquariumDetails extends StatefulWidget {
  const AquariumDetails({super.key});

  @override
  State<StatefulWidget> createState() => _AquariumDetailsState();
}

class _AquariumDetailsState extends State<AquariumDetails> {
  int _selectedBottomIndex = 0;
  final double currentTemperature = 25.5;
  final double currentPh = 8.2;
  final double currentSalinity = 1.024;
  final String statusMessage = "ALL GOOD";
  bool lightsOn = true;
  bool pumpOn = true;
  bool heaterOn = false;
  bool co2On = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3a3a3a),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                    onPressed: () {},
                  ),
                  const Text('La Mia Vasca', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF4a4a4a), Color(0xFF2d2d2d)]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                            child: const Text('Check Status', style: TextStyle(color: Colors.white, fontSize: 12)),
                          ),
                          const SizedBox(height: 20),
                          Text(statusMessage, style: const TextStyle(color: Colors.white, fontSize: 56, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(colors: [Color(0xFF60a5fa).withOpacity(0.2), Color(0xFF2dd4bf).withOpacity(0.1)]),
                            ),
                            child: Center(child: Icon(Icons.water_drop, size: 80, color: Color(0xFF60a5fa).withOpacity(0.5))),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Updated from sensors on 11/7/2025 11:22 AM',
                            style: TextStyle(color: Colors.white70, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Status Bar
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2d2d2d),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.thermostat, color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          const Text('Temperature', style: TextStyle(color: Colors.white70, fontSize: 13)),
                          const Spacer(),
                          Text('${currentTemperature.toStringAsFixed(1)}°C', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          const Text(' / 25.0°C', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Quick Actions
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2d2d2d),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildActionButton(Icons.lightbulb_outline, lightsOn),
                          _buildActionButton(Icons.water_outlined, pumpOn),
                          _buildActionButton(Icons.thermostat_outlined, heaterOn),
                          _buildActionButton(Icons.air, co2On),
                          _buildActionButton(Icons.waves, false),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Info Cards
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(child: _buildInfoCard('pH Level', 'pH Monitor', currentPh.toStringAsFixed(1), Icons.science_outlined)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildInfoCard('Salinity', 'Conductivity', currentSalinity.toStringAsFixed(3), Icons.water_outlined)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2d2d2d),
          boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 20, offset: const Offset(0, -5))],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.view_module_outlined, 0),
                _buildNavItem(Icons.map_outlined, 1),
                _buildNavItem(Icons.show_chart, 2),
                _buildNavItem(Icons.person_outline, 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, bool isActive) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF60a5fa).withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isActive ? const Color(0xFF60a5fa).withOpacity(0.5) : Colors.white12),
      ),
      child: Icon(icon, color: isActive ? const Color(0xFF60a5fa) : Colors.white60, size: 24),
    );
  }

  Widget _buildInfoCard(String title, String subtitle, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2d2d2d),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white60, size: 32),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 11)),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _selectedBottomIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedBottomIndex = index);
        if (index == 2) Navigator.pushNamed(context, RouteNames.parametersCharts);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF60a5fa).withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: isSelected ? const Color(0xFF60a5fa) : Colors.white60, size: 26),
      ),
    );
  }
}
