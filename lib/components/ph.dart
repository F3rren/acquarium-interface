import 'package:flutter/material.dart';

class PhMeter extends StatelessWidget {
  final double currentPh;
  final double? targetPh;
  final DateTime? lastUpdated;
  final String? deviceName;

  const PhMeter({
    super.key,
    this.currentPh = 8.2,
    this.targetPh,
    this.lastUpdated,
    this.deviceName,
  });

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('pH (Potenziale Idrogeno)'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Il pH rappresenta il grado di acidità o basicità dell\'acqua e costituisce uno dei parametri chimici più sensibili in acquario marino. Nel sistema marino, deve rimanere costantemente stabile nell\'intervallo alcalino tipico degli oceani tropicali, compreso tra 8.0 e 8.4.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              Text(
                'Importanza:\n• Fondamentale per la salute metabolica di pesci, coralli e invertebrati\n• Determinante per la calcificazione scheletrica nei coralli\n• Influenza la biodisponibilità e l’assorbimento dei nutrienti\n• Regola l’attività enzimatica e i processi biochimici vitali',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Effetti fuori range:\n• Valori inferiori a 8.0: stress fisiologico, difficoltà respiratoria, corrosione delle strutture calcificate\n• Valori superiori a 8.4: stress osmotico, possibile precipitazione di nutrienti (Ca, Mg)\n• Oscillazioni frequenti: predisposizione a malattie, alterazioni del metabolismo e riduzione crescita corallina',
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

  Color _getPhColor() {
    if (currentPh < 7.5) return const Color(0xFFF44336); // Rosso - troppo acido
    if (currentPh < 8.0) return const Color(0xFFFF9800); // Arancione - basso
    if (currentPh >= 8.0 && currentPh <= 8.4)
      return const Color(0xFF8BC34A); // Verde - IDEALE
    if (currentPh <= 8.6)
      return const Color(0xFFFFC107); // Giallo - leggermente alto
    if (currentPh <= 8.8) return const Color(0xFFFF9800); // Arancione - alto
    return const Color(0xFFF44336); // Rosso - troppo alcalino
  }

  String _getPhStatus() {
    if (currentPh < 7.5) return 'Troppo Acido';
    if (currentPh < 8.0) return 'Basso';
    if (currentPh >= 8.0 && currentPh <= 8.4) return 'Ottimale';
    if (currentPh <= 8.6) return 'Leggermente Alto';
    if (currentPh <= 8.8) return 'Alto';
    return 'Troppo Alcalino';
  }

  IconData _getStatusIcon() {
    if (currentPh < 7.5 || currentPh > 8.8) return Icons.error;
    if (currentPh >= 8.0 && currentPh <= 8.4) return Icons.check_circle;
    return Icons.warning_amber;
  }

  String _getMarineAdvice() {
    if (currentPh < 7.5) {
      return 'PERICOLO: pH troppo basso, stress estremo per pesci e coralli!';
    } else if (currentPh < 8.0) {
      return 'pH sotto il range marino, aumentare gradualmente';
    } else if (currentPh >= 8.0 && currentPh <= 8.4) {
      return 'pH ideale per acquario marino tropicale';
    } else if (currentPh <= 8.6) {
      return 'pH leggermente alto, monitorare attentamente';
    } else if (currentPh <= 8.8) {
      return 'pH alto: possibile stress per gli abitanti';
    } else {
      return 'PERICOLO: pH troppo alto, intervenire immediatamente!';
    }
  }

  // Genera la scala del pH con gradiente
  Widget _buildPhScale() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFF44336), // Rosso (acido)
            Color(0xFFFF9800), // Arancione
            Color(0xFFFFC107), // Giallo
            Color(0xFF8BC34A), // Verde (ideale)
            Color(0xFFFFC107), // Giallo
            Color(0xFFFF9800), // Arancione
            Color(0xFFF44336), // Rosso (alcalino)
          ],
          stops: [0.0, 0.2, 0.35, 0.5, 0.65, 0.8, 1.0],
        ),
        border: Border.all(color: Colors.grey[400]!, width: 2),
      ),
      child: Stack(
        children: [
          // Indicatore posizione pH attuale
          Positioned(
            left: _getPhPosition(),
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
                  _buildScaleLabel('7.0'),
                  _buildScaleLabel('8.0'),
                  _buildScaleLabel('8.4'),
                  _buildScaleLabel('9.0'),
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

  double _getPhPosition() {
    // Mappa pH 7.0-9.0 sulla larghezza del container
    // Assumendo larghezza ~300px (aggiustato dinamicamente dal layout)
    const minPh = 7.0;
    const maxPh = 9.0;
    final normalized = ((currentPh - minPh) / (maxPh - minPh)).clamp(0.0, 1.0);
    return normalized * 280; // ~300px - padding
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
              // Icona pH a sinistra
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _getPhColor().withOpacity(0.2),
                      _getPhColor().withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.water_drop, size: 64, color: _getPhColor()),
              ),
              const SizedBox(width: 24),
              // Informazioni a destra
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "pH Acqua",
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
                        Icon(_getStatusIcon(), size: 20, color: _getPhColor()),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentPh.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: _getPhColor(),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getPhColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getPhStatus(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getPhColor(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Scala pH visuale
          _buildPhScale(),
          const SizedBox(height: 16),
          // Consigli specifici per acquario marino
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
          if (targetPh != null) ...[
            const SizedBox(height: 8),
            _buildInfoChip('Target', targetPh!.toStringAsFixed(2), Icons.flag),
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
