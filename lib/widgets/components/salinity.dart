import 'package:flutter/material.dart';

class SalinityMeter extends StatelessWidget {
  final double currentSalinity;
  final double? targetSalinity;

  const SalinityMeter({
    super.key,
    this.currentSalinity = 1.024,
    this.targetSalinity,
  });

  Color _getSalinityColor() {
    if (currentSalinity < 1.023) return const Color(0xFFef4444);
    if (currentSalinity >= 1.023 && currentSalinity <= 1.025) return const Color(0xFF34d399);
    return const Color(0xFFef4444);
  }

  String _getStatus() {
    if (currentSalinity < 1.023) return 'Bassa';
    if (currentSalinity >= 1.023 && currentSalinity <= 1.025) return 'Ottimale';
    return 'Alta';
  }

  @override
  Widget build(BuildContext context) {
    final color = _getSalinityColor();
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
                child: Icon(Icons.opacity, color: color, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Salinità', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
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
                  currentSalinity.toStringAsFixed(3),
                  style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          if (targetSalinity != null) ...[
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
                    targetSalinity!.toStringAsFixed(3),
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
    final progress = ((currentSalinity - 1.020) / (1.030 - 1.020)).clamp(0.0, 1.0);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('1.020', style: TextStyle(color: Colors.white60, fontSize: 11)),
            const Text('1.030', style: TextStyle(color: Colors.white60, fontSize: 11)),
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
