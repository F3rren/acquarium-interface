import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HealthDashboard extends StatelessWidget {
  const HealthDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    const currentTemperature = 25.5;
    const statusMessage = "ALL GOOD";

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Card - Check Status
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF4a4a4a), Color(0xFF3a3a3a)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Check Status',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  statusMessage,
                  style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Aggiornato 5 minuti fa',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Temperature Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF3a3a3a),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              children: [
                const Icon(Icons.thermostat, color: Colors.white70, size: 20),
                const SizedBox(width: 8),
                const Text('Temperature', style: TextStyle(color: Colors.white70, fontSize: 13)),
                const Spacer(),
                Text(
                  '${currentTemperature.toStringAsFixed(1)}°C',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildHealthScore(),
          const SizedBox(height: 20),
          _buildQuickStats(),
          const SizedBox(height: 24),
          _buildTrendCharts(),
          const SizedBox(height: 24),
          _buildActivityTimeline(),
          const SizedBox(height: 24),
          _buildRecommendations(),
        ],
      ),
    );
  }

  Widget _buildHealthScore() {
    const score = 85;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF4a4a4a), Color(0xFF3a3a3a)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 8,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF34d399)),
                  ),
                ),
                const Center(
                  child: Text('$score', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Health Score', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Buono', style: TextStyle(color: Color(0xFF34d399), fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                Text('Tutti i parametri nel range ottimale', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Parametri OK', '6', Icons.check_circle, const Color(0xFF34d399))),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Alert', '0', Icons.warning_amber, const Color(0xFFef4444))),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Check', '5m', Icons.access_time, const Color(0xFF60a5fa))),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF3a3a3a),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildTrendCharts() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3a3a3a),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.trending_up, color: Color(0xFF60a5fa), size: 20),
              SizedBox(width: 8),
              Text('Andamento Ultimi 7 Giorni', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 20),
          _buildMiniChart('Temperatura', const Color(0xFFef4444), [24.5, 24.8, 25.2, 25.0, 24.9, 25.1, 25.3]),
          const SizedBox(height: 12),
          _buildMiniChart('pH', const Color(0xFF60a5fa), [8.1, 8.15, 8.2, 8.25, 8.2, 8.18, 8.22]),
          const SizedBox(height: 12),
          _buildMiniChart('Salinità', const Color(0xFF2dd4bf), [1.023, 1.024, 1.024, 1.025, 1.024, 1.023, 1.024]),
        ],
      ),
    );
  }

  Widget _buildMiniChart(String label, Color color, List<double> data) {
    final spots = data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
            Text(data.last.toStringAsFixed(2), style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 60,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: (data.length - 1).toDouble(),
              minY: data.reduce((a, b) => a < b ? a : b) * 0.98,
              maxY: data.reduce((a, b) => a > b ? a : b) * 1.02,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: color,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: color.withValues(alpha: 0.15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityTimeline() {
    final activities = [
      {'title': 'Temperatura stabile', 'time': '2 ore fa', 'icon': Icons.check_circle, 'color': const Color(0xFF34d399)},
      {'title': 'pH regolato', 'time': '5 ore fa', 'icon': Icons.science, 'color': const Color(0xFF60a5fa)},
      {'title': 'Cambio acqua', 'time': '1 giorno fa', 'icon': Icons.water, 'color': const Color(0xFF2dd4bf)},
      {'title': 'Test parametri', 'time': '2 giorni fa', 'icon': Icons.analytics, 'color': const Color(0xFFa855f7)},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3a3a3a),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Activity Timeline', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          ...activities.map((activity) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (activity['color'] as Color).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(activity['icon'] as IconData, color: activity['color'] as Color, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(activity['title'] as String, style: const TextStyle(color: Colors.white, fontSize: 13)),
                      Text(activity['time'] as String, style: const TextStyle(color: Colors.white60, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    final recommendations = [
      {'title': 'Controllare skimmer', 'desc': 'Pulizia settimanale consigliata', 'icon': Icons.cleaning_services, 'urgent': false},
      {'title': 'Test KH', 'desc': 'Ultimo test: 3 giorni fa', 'icon': Icons.science, 'urgent': false},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3a3a3a),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Raccomandazioni', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          ...recommendations.map((rec) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF2d2d2d),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (rec['urgent'] as bool ? const Color(0xFFfbbf24) : const Color(0xFF60a5fa)).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(rec['icon'] as IconData, color: rec['urgent'] as bool ? const Color(0xFFfbbf24) : const Color(0xFF60a5fa), size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rec['title'] as String, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(rec['desc'] as String, style: const TextStyle(color: Colors.white60, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
