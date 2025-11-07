import 'package:flutter/material.dart';

class SalinityMeter extends StatelessWidget {
  final double currentSalinity;
  final double? targetSalinity;
  final DateTime? lastUpdated;
  final String? deviceName;

  const SalinityMeter({
    super.key,
    this.currentSalinity = 1.024,
    this.targetSalinity,
    this.lastUpdated,
    this.deviceName,
  });

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Salinità (Densità)'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'La salinità rappresenta la quantità totale di sali minerali disciolti nell\'acqua marina, misurata principalmente come densità relativa (peso specifico) oppure in parti per mille (‰). Un controllo accurato di questo parametro è essenziale per mantenere la corretta fisiologia di tutti gli organismi marini.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              Text(
                'Importanza:\n• Mantiene l\'equilibrio osmotico di pesci, coralli e invertebrati\n• Regola le funzioni vitali cellulari (trasporto ioni, idratazione)\n• Influisce su densità, galleggiamento e distribuzione degli organismi\n• Determina la solubilità di gas (ossigeno, anidride carbonica) e nutrienti',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Effetti fuori range:\n• Valori inferiori al range ottimale: stress osmotico, gonfiore cellulare e rischio di squilibri fisiologici\n• Valori superiori: disidratazione, alterazioni ioniche e stress metabolico\n• L\'evaporazione aumenta automaticamente la salinità, occorre integrare esclusivamente con acqua dolce osmotica per riportare i livelli corretti',
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

  Color _getSalinityColor() {
    if (currentSalinity < 1.020)
      return const Color(0xFFF44336); // Rosso - troppo bassa
    if (currentSalinity < 1.023)
      return const Color(0xFFFF9800); // Arancione - bassa
    if (currentSalinity >= 1.023 && currentSalinity <= 1.025)
      return const Color(0xFF8BC34A); // Verde - IDEALE
    if (currentSalinity <= 1.027)
      return const Color(0xFFFFC107); // Giallo - leggermente alta
    if (currentSalinity <= 1.029)
      return const Color(0xFFFF9800); // Arancione - alta
    return const Color(0xFFF44336); // Rosso - troppo alta
  }

  String _getSalinityStatus() {
    if (currentSalinity < 1.020) return 'Troppo Bassa';
    if (currentSalinity < 1.023) return 'Bassa';
    if (currentSalinity >= 1.023 && currentSalinity <= 1.025) return 'Ottimale';
    if (currentSalinity <= 1.027) return 'Leggermente Alta';
    if (currentSalinity <= 1.029) return 'Alta';
    return 'Troppo Alta';
  }

  IconData _getStatusIcon() {
    if (currentSalinity < 1.020 || currentSalinity > 1.029) return Icons.error;
    if (currentSalinity >= 1.023 && currentSalinity <= 1.025)
      return Icons.check_circle;
    return Icons.warning_amber;
  }

  String _getMarineAdvice() {
    if (currentSalinity < 1.020) {
      return 'PERICOLO: Salinità critica, stress osmotico per gli abitanti!';
    } else if (currentSalinity < 1.023) {
      return 'Salinità bassa, aumentare gradualmente con sale marino';
    } else if (currentSalinity >= 1.023 && currentSalinity <= 1.025) {
      return 'Salinità ideale per acquario marino tropicale';
    } else if (currentSalinity <= 1.027) {
      return 'Salinità leggermente alta, monitorare evaporazione';
    } else if (currentSalinity <= 1.029) {
      return 'Salinità alta: controllare rabbocco acqua dolce';
    } else {
      return 'PERICOLO: Salinità troppo alta, cambi d\'acqua urgenti!';
    }
  }

  // Converte salinità in PPT (parti per mille)
  String _getSalinityPPT() {
    // Densità relativa a PPT: approssimazione (1.0 = 0 ppt, 1.026 ≈ 35 ppt)
    final ppt = (currentSalinity - 1.0) * 1346; // Formula approssimativa
    return ppt.toStringAsFixed(1);
  }

  Widget _buildSalinityScale() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFF44336), // Rosso (bassa)
            Color(0xFFFF9800), // Arancione
            Color(0xFF8BC34A), // Verde (ideale)
            Color(0xFFFFC107), // Giallo
            Color(0xFFFF9800), // Arancione
            Color(0xFFF44336), // Rosso (alta)
          ],
          stops: [0.0, 0.15, 0.4, 0.6, 0.85, 1.0],
        ),
        border: Border.all(color: Colors.grey[400]!, width: 2),
      ),
      child: Stack(
        children: [
          // Indicatore posizione salinità attuale
          Positioned(
            left: _getSalinityPosition(),
            child: Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
          // Etichette scala
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildScaleLabel('1.020'),
                  _buildScaleLabel('1.023'),
                  _buildScaleLabel('1.025'),
                  _buildScaleLabel('1.030'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScaleLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  double _getSalinityPosition() {
    const minSal = 1.020;
    const maxSal = 1.030;
    final normalized = ((currentSalinity - minSal) / (maxSal - minSal)).clamp(
      0.0,
      1.0,
    );
    return normalized * 280;
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
              // Icona salinità
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _getSalinityColor().withOpacity(0.2),
                      _getSalinityColor().withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.water, size: 64, color: _getSalinityColor()),
              ),
              const SizedBox(width: 24),
              // Informazioni
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Salinità",
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
                        Icon(
                          _getStatusIcon(),
                          size: 20,
                          color: _getSalinityColor(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          currentSalinity.toStringAsFixed(3),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: _getSalinityColor(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${_getSalinityPPT()} ppt)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getSalinityColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getSalinityStatus(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getSalinityColor(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSalinityScale(),
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
          if (targetSalinity != null) ...[
            const SizedBox(height: 8),
            _buildInfoChip(
              'Target',
              targetSalinity!.toStringAsFixed(3),
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
