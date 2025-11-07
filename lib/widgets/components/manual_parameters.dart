import 'package:flutter/material.dart';

class ManualParametersWidget extends StatefulWidget {
  const ManualParametersWidget({super.key});

  @override
  State<ManualParametersWidget> createState() => _ManualParametersWidgetState();
}

class _ManualParametersWidgetState extends State<ManualParametersWidget> {
  double calcium = 420.0;
  double magnesium = 1300.0;
  double kh = 8.0;
  double nitrates = 2.0;
  double phosphates = 0.02;

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF60a5fa).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.science, color: Color(0xFF60a5fa), size: 24),
              ),
              const SizedBox(width: 12),
              const Text(
                'Parametri Chimici',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildParameter('Calcio (Ca)', calcium, 'mg/L', 400, 450, Icons.layers, (v) => setState(() => calcium = v)),
          const SizedBox(height: 12),
          _buildParameter('Magnesio (Mg)', magnesium, 'mg/L', 1250, 1350, Icons.auto_awesome, (v) => setState(() => magnesium = v)),
          const SizedBox(height: 12),
          _buildParameter('KH', kh, 'dKH', 7, 9, Icons.bar_chart, (v) => setState(() => kh = v)),
          const SizedBox(height: 12),
          _buildParameter('Nitrati (NO3)', nitrates, 'mg/L', 0.5, 5, Icons.eco, (v) => setState(() => nitrates = v)),
          const SizedBox(height: 12),
          _buildParameter('Fosfati (PO4)', phosphates, 'mg/L', 0.0, 0.03, Icons.water_damage, (v) => setState(() => phosphates = v)),
        ],
      ),
    );
  }

  Widget _buildParameter(String name, double value, String unit, double min, double max, IconData icon, Function(double) onChanged) {
    final isInRange = value >= min && value <= max;
    final color = isInRange ? const Color(0xFF34d399) : const Color(0xFFef4444);
    
    return Container(
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
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text('$min-$max $unit', style: const TextStyle(color: Colors.white60, fontSize: 11)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showEditDialog(name, value, unit, onChanged),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withValues(alpha: 0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${value.toStringAsFixed(value < 10 ? 2 : 0)}',
                    style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  Text(unit, style: TextStyle(color: color, fontSize: 11)),
                  const SizedBox(width: 6),
                  Icon(Icons.edit, color: color, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(String name, double currentValue, String unit, Function(double) onChanged) {
    final controller = TextEditingController(text: currentValue.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2d2d2d),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Modifica $name', style: const TextStyle(color: Colors.white, fontSize: 18)),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Valore ($unit)',
            labelStyle: const TextStyle(color: Colors.white60),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF60a5fa)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla', style: TextStyle(color: Colors.white60)),
          ),
          ElevatedButton(
            onPressed: () {
              final value = double.tryParse(controller.text);
              if (value != null) {
                onChanged(value);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF60a5fa),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Salva'),
          ),
        ],
      ),
    );
  }
}
