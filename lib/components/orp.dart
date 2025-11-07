import 'package:flutter/material.dart';

class OrpMeter extends StatelessWidget {
  final double currentOrp;
  final double? targetOrp;
  final DateTime? lastUpdated;
  final String? deviceName;

  const OrpMeter({
    super.key,
    this.currentOrp = 350.0,
    this.targetOrp,
    this.lastUpdated,
    this.deviceName,
  });

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ORP/Redox'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'L\'ORP (Potenziale di Ossido-Riduzione, Redox) rappresenta la capacità globale dell\'acqua di acquario di ossidare o ridurre sostanze chimiche. È espresso in millivolt (mV) e costituisce un indice diretto dello stato chimico, biologico e della “pulizia” dell’ambiente acquatico. Valori stabilmente ottimali testimoniano un ecosistema efficiente e correttamente gestito.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              Text(
                'Importanza:\n• Indicatore universale della qualità e della maturazione dell\'acqua\n• Valuta l’efficacia della filtrazione biologica e dei processi batterici\n• Rileva la presenza (eccesso o deficit) di sostanze organiche o inquinanti\n• Determina il potere ossidante, utile nelle gestioni con ozono o UV',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Effetti fuori range:\n• Valori inferiori a 300 mV: accumulo di sostanze organiche, rallentamento biomasse batteriche, ridotta ossigenazione, rischio di crisi e odori sgradevoli\n• Valori superiori a 400 mV: eccessivo potere ossidante, possibile stress/sbiancamento coralli, alterazioni dei processi di riduzione\n• Valori stabili tra 300 e 400 mV: sistema equilibrato e ambiente marino idoneo per coralli, pesci e invertebrati',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.orange[800],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Chiudi'),
          ),
        ],
      ),
    );
  }

  Color _getOrpColor() {
    if (currentOrp < 200)
      return const Color(0xFFF44336); // Rosso - ossidazione scarsa
    if (currentOrp < 300) return const Color(0xFFFF9800); // Arancione - basso
    if (currentOrp >= 300 && currentOrp <= 400)
      return const Color(0xFF8BC34A); // Verde - IDEALE
    if (currentOrp <= 450)
      return const Color(0xFFFFC107); // Giallo - leggermente alto
    if (currentOrp <= 500) return const Color(0xFFFF9800); // Arancione - alto
    return const Color(0xFFF44336); // Rosso - troppo alto
  }

  String _getOrpStatus() {
    if (currentOrp < 200) return 'Critico';
    if (currentOrp < 300) return 'Basso';
    if (currentOrp >= 300 && currentOrp <= 400) return 'Ottimale';
    if (currentOrp <= 450) return 'Leggermente Alto';
    if (currentOrp <= 500) return 'Alto';
    return 'Troppo Alto';
  }

  IconData _getStatusIcon() {
    if (currentOrp < 200 || currentOrp > 500) return Icons.error;
    if (currentOrp >= 300 && currentOrp <= 400) return Icons.check_circle;
    return Icons.warning_amber;
  }

  String _getMarineAdvice() {
    if (currentOrp < 200) {
      return 'PERICOLO: Acqua di bassa qualità, rischio per gli abitanti';
    } else if (currentOrp < 300) {
      return 'ORP basso: controllare filtrazione e skimmer';
    } else if (currentOrp >= 300 && currentOrp <= 400) {
      return 'ORP ideale: acqua di ottima qualità, ambiente stabile';
    } else if (currentOrp <= 450) {
      return 'ORP leggermente alto: ridurre ossigenazione se necessario';
    } else if (currentOrp <= 500) {
      return 'ORP alto: controllare ozonizzatore se presente';
    } else {
      return 'ATTENZIONE: ORP eccessivo, può danneggiare organismi';
    }
  }

  Widget _buildOrpGauge() {
    return Container(
      height: 120,
      child: Stack(
        children: [
          // Gauge circolare
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CustomPaint(
                painter: _OrpGaugePainter(
                  value: currentOrp,
                  color: _getOrpColor(),
                ),
              ),
            ),
          ),
          // Valore al centro
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${currentOrp.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _getOrpColor(),
                  ),
                ),
                Text(
                  'mV',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "ORP/Redox",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _showInfoDialog(context),
                child: Icon(
                  Icons.info_outline,
                  size: 20,
                  color: Colors.blue[600],
                ),
              ),
              const SizedBox(width: 8),
              Icon(_getStatusIcon(), size: 20, color: _getOrpColor()),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getOrpColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _getOrpStatus(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getOrpColor(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildOrpGauge(),
          const SizedBox(height: 16),
          // Consigli
          Row(
            children: [
              //Icon(Icons.info_outline, size: 16, color: Colors.blue[700]),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  _getMarineAdvice(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (targetOrp != null) ...[
            const SizedBox(height: 8),
            _buildInfoChip(
              'Target',
              '${targetOrp!.toStringAsFixed(0)} mV',
              Icons.flag,
            ),
          ],
          if (lastUpdated != null) ...[
            const SizedBox(height: 8),
            _buildInfoChip(
              'Ultimo aggiornamento',
              _formatTime(lastUpdated!),
              Icons.access_time,
            ),
          ],
          if (deviceName != null) ...[
            const SizedBox(height: 8),
            _buildInfoChip('Sensore', deviceName!, Icons.sensors),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) return 'Adesso';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m fa';
    if (difference.inHours < 24) return '${difference.inHours}h fa';
    return '${difference.inDays}g fa';
  }
}

// Custom painter per il gauge circolare
class _OrpGaugePainter extends CustomPainter {
  final double value;
  final Color color;

  _OrpGaugePainter({required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background arc
    final bgPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.75 * 3.14159, // Start angle (-135 degrees)
      1.5 * 3.14159, // Sweep angle (270 degrees)
      false,
      bgPaint,
    );

    // Value arc (0-600 mV range)
    final normalizedValue = (value / 600).clamp(0.0, 1.0);
    final valuePaint = Paint()
      ..shader = LinearGradient(
        colors: [color.withOpacity(0.5), color],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.75 * 3.14159,
      1.5 * 3.14159 * normalizedValue,
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(_OrpGaugePainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.color != color;
  }
}
