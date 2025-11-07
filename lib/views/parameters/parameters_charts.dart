import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ParametersCharts extends StatefulWidget {
  const ParametersCharts({super.key});

  @override
  State<ParametersCharts> createState() => _ParametersChartsState();
}

class _ParametersChartsState extends State<ParametersCharts> {
  String _selectedParameter = 'Temperatura';
  String _selectedPeriod = '7 giorni';

  final Map<String, List<FlSpot>> _mockData = {
    'Temperatura': [
      const FlSpot(0, 24.5), const FlSpot(1, 24.8), const FlSpot(2, 25.2),
      const FlSpot(3, 25.0), const FlSpot(4, 24.9), const FlSpot(5, 25.1), const FlSpot(6, 25.3),
    ],
    'pH': [
      const FlSpot(0, 8.1), const FlSpot(1, 8.15), const FlSpot(2, 8.2),
      const FlSpot(3, 8.25), const FlSpot(4, 8.2), const FlSpot(5, 8.18), const FlSpot(6, 8.22),
    ],
    'Salinità': [
      const FlSpot(0, 1.023), const FlSpot(1, 1.024), const FlSpot(2, 1.024),
      const FlSpot(3, 1.025), const FlSpot(4, 1.024), const FlSpot(5, 1.023), const FlSpot(6, 1.024),
    ],
    'Calcio': [
      const FlSpot(0, 410), const FlSpot(1, 415), const FlSpot(2, 420),
      const FlSpot(3, 425), const FlSpot(4, 420), const FlSpot(5, 418), const FlSpot(6, 422),
    ],
    'Magnesio': [
      const FlSpot(0, 1280), const FlSpot(1, 1290), const FlSpot(2, 1300),
      const FlSpot(3, 1310), const FlSpot(4, 1305), const FlSpot(5, 1298), const FlSpot(6, 1302),
    ],
    'KH': [
      const FlSpot(0, 7.8), const FlSpot(1, 7.9), const FlSpot(2, 8.0),
      const FlSpot(3, 8.1), const FlSpot(4, 8.0), const FlSpot(5, 7.9), const FlSpot(6, 8.0),
    ],
  };

  final Map<String, Map<String, dynamic>> _parameterInfo = {
    'Temperatura': {'unit': '°C', 'min': 24.0, 'max': 26.0, 'color': const Color(0xFFef4444), 'icon': Icons.thermostat},
    'pH': {'unit': '', 'min': 8.0, 'max': 8.4, 'color': const Color(0xFF60a5fa), 'icon': Icons.science_outlined},
    'Salinità': {'unit': '', 'min': 1.023, 'max': 1.025, 'color': const Color(0xFF2dd4bf), 'icon': Icons.water_outlined},
    'Calcio': {'unit': 'mg/L', 'min': 400.0, 'max': 450.0, 'color': const Color(0xFFa855f7), 'icon': Icons.analytics},
    'Magnesio': {'unit': 'mg/L', 'min': 1250.0, 'max': 1350.0, 'color': const Color(0xFFec4899), 'icon': Icons.bubble_chart},
    'KH': {'unit': 'dKH', 'min': 7.0, 'max': 9.0, 'color': const Color(0xFF34d399), 'icon': Icons.show_chart},
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildHeader(),
          const SizedBox(height: 20),
          _buildPeriodSelector(),
          const SizedBox(height: 20),
          _buildMainChart(),
          const SizedBox(height: 20),
          _buildStatistics(),
          const SizedBox(height: 20),
          _buildParameterGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4a4a4a), Color(0xFF3a3a3a)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF60a5fa).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.trending_up, color: Color(0xFF60a5fa), size: 32),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Analisi Parametri', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Monitoraggio avanzato dei valori', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
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
          const Text('Periodo', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
          const SizedBox(height: 12),
          Row(
            children: ['7 giorni', '30 giorni', '3 mesi', '1 anno'].map((period) {
              final isSelected = _selectedPeriod == period;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedPeriod = period),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF60a5fa).withValues(alpha: 0.2) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? const Color(0xFF60a5fa) : Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        period,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF60a5fa) : Colors.white60,
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainChart() {
    final data = _mockData[_selectedParameter]!;
    final info = _parameterInfo[_selectedParameter]!;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3a3a3a),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (info['color'] as Color).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(info['icon'], color: info['color'], size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_selectedParameter, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(_selectedPeriod, style: const TextStyle(color: Colors.white60, fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF34d399).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF34d399).withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Color(0xFF34d399), size: 14),
                    const SizedBox(width: 4),
                    const Text('OK', style: TextStyle(color: Color(0xFF34d399), fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: (info['max'] - info['min']) / 4,
                  getDrawingHorizontalLine: (value) => FlLine(color: Colors.white.withValues(alpha: 0.1), strokeWidth: 1),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) => Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text('${value.toInt()}', style: const TextStyle(color: Colors.white60, fontSize: 11)),
                      ),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: (info['max'] - info['min']) / 4,
                      reservedSize: 45,
                      getTitlesWidget: (value, meta) => Text(
                        value.toStringAsFixed(1),
                        style: const TextStyle(color: Colors.white60, fontSize: 11),
                      ),
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: info['min'] - (info['max'] - info['min']) * 0.1,
                maxY: info['max'] + (info['max'] - info['min']) * 0.1,
                lineBarsData: [
                  LineChartBarData(
                    spots: data,
                    isCurved: true,
                    color: info['color'],
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                        radius: 4,
                        color: info['color'],
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: (info['color'] as Color).withValues(alpha: 0.15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    final data = _mockData[_selectedParameter]!;
    final values = data.map((spot) => spot.y).toList();
    final avg = values.reduce((a, b) => a + b) / values.length;
    final max = values.reduce((a, b) => a > b ? a : b);
    final min = values.reduce((a, b) => a < b ? a : b);
    final info = _parameterInfo[_selectedParameter]!;

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
          const Text('Statistiche', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatCard('Media', avg.toStringAsFixed(2), info['unit'], Icons.trending_flat, const Color(0xFF60a5fa))),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('Max', max.toStringAsFixed(2), info['unit'], Icons.trending_up, const Color(0xFFef4444))),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('Min', min.toStringAsFixed(2), info['unit'], Icons.trending_down, const Color(0xFF34d399))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String unit, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.white60)),
          const SizedBox(height: 4),
          Text('$value$unit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildParameterGrid() {
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
          const Text('Tutti i Parametri', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
            ),
            itemCount: _parameterInfo.length,
            itemBuilder: (context, index) {
              final param = _parameterInfo.keys.elementAt(index);
              return _buildParameterCard(param);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildParameterCard(String param) {
    final data = _mockData[param]!;
    final info = _parameterInfo[param]!;
    final lastValue = data.last.y;
    final isSelected = _selectedParameter == param;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _selectedParameter = param),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? (info['color'] as Color).withValues(alpha: 0.15) : const Color(0xFF2d2d2d),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? info['color'] : Colors.white.withValues(alpha: 0.1),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(info['icon'], color: info['color'], size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      param,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? Colors.white : Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '${lastValue.toStringAsFixed(2)} ${info['unit']}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: info['color'],
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 6,
                    minY: info['min'] - (info['max'] - info['min']) * 0.1,
                    maxY: info['max'] + (info['max'] - info['min']) * 0.1,
                    lineBarsData: [
                      LineChartBarData(
                        spots: data,
                        isCurved: true,
                        color: info['color'],
                        barWidth: 2,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: (info['color'] as Color).withValues(alpha: 0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
