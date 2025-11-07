import 'package:flutter/material.dart';

class OrpMeter extends StatelessWidget {
  final double currentOrp;
  final double? targetOrp;

  const OrpMeter({
    super.key,
    this.currentOrp = 350.0,
    this.targetOrp,
  });

  Color _getOrpColor() {
    if (currentOrp < 300) return const Color(0xFFef4444);
    if (currentOrp >= 300 && currentOrp <= 400) return const Color(0xFF34d399);
    return const Color(0xFFef4444);
  }

  String _getStatus() {
    if (currentOrp < 300) return 'Basso';
    if (currentOrp >= 300 && currentOrp <= 400) return 'Ottimale';
    return 'Alto';
  }

  @override
  Widget build(BuildContext context) {
    final color = _getOrpColor();
    final status = _getStatus();

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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.science, color: color, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ORP/Redox', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withValues(alpha: 0.4)),
                ),
                child: Text(
                  '${currentOrp.toStringAsFixed(0)} mV',
                  style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          if (targetOrp != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2d2d2d),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.track_changes, color: Colors.white60, size: 18),
                      SizedBox(width: 8),
                      Text('Target', style: TextStyle(color: Colors.white60, fontSize: 13)),
                    ],
                  ),
                  Text(
                    '${targetOrp!.toStringAsFixed(0)} mV',
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          _buildProgressBar(color),
        ],
      ),
    );
  }

  Widget _buildProgressBar(Color color) {
    final progress = ((currentOrp - 200) / (500 - 200)).clamp(0.0, 1.0);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('200 mV', style: TextStyle(color: Colors.white60, fontSize: 11)),
            const Text('500 mV', style: TextStyle(color: Colors.white60, fontSize: 11)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFF2d2d2d),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
