import 'package:flutter/material.dart';

class Thermometer extends StatelessWidget {
  final double currentTemperature;
  final double? targetTemperature;
  final DateTime? lastUpdated;
  final String? deviceName;

  const Thermometer({
    super.key,
    required this.currentTemperature,
    this.targetTemperature,
    this.lastUpdated,
    this.deviceName,
  });

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Temperatura'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'La temperatura rappresenta uno dei parametri fisici più determinanti per la salute di ogni ecosistema marino in acquario. Mantenere il valore costante e stabile è fondamentale per prevenire stress metabolico, disfunzioni immunitarie e squilibri nella fisiologia di coralli, pesci e invertebrati.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              Text(
                'Importanza:\n• Regola il metabolismo e il ritmo circadiano di pesci e coralli\n• Influisce sulla solubilità e sulla saturazione dell’ossigeno disciolto\n• Determina l’efficienza delle comunità batteriche nel filtro biologico\n• Contribuisce continuamente alla stabilità generale dell’ecosistema acquatico',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Effetti fuori range:\n• Valori inferiori a 24°C: metabolismo rallentato, riduzione delle difese immunitarie, crescita subottimale di coralli e batteri\n• Valori superiori a 26°C: stress termico, rischio di bleaching (sbiancamento) nei coralli, ridotta concentrazione di ossigeno, predisposizione a malattie\n• Variazioni rapide o improvvise: shock termico, possibili fatalità per gli organismi più sensibili',
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

  Color _getTemperatureColor() {
    if (currentTemperature < 20) return const Color(0xFF2196F3); // Blu freddo
    if (currentTemperature < 24) return const Color(0xFF4CAF50); // Verde chiaro
    if (currentTemperature >= 24 && currentTemperature <= 26)
      return const Color(0xFF8BC34A); // Verde lime - IDEALE
    if (currentTemperature < 28)
      return const Color(0xFFFFC107); // Giallo/Arancione
    if (currentTemperature < 30) return const Color(0xFFFF9800); // Arancione
    return const Color(0xFFF44336); // Rosso caldo
  }

  String _getTemperatureStatus() {
    if (currentTemperature < 20) return 'Troppo Freddo';
    if (currentTemperature < 24) return 'Bassa';
    if (currentTemperature >= 24 && currentTemperature <= 26) return 'Ottimale';
    if (currentTemperature < 28) return 'Leggermente Alta';
    if (currentTemperature < 30) return 'Alta';
    return 'Critica';
  }

  IconData _getStatusIcon() {
    if (currentTemperature < 20) return Icons.ac_unit;
    if (currentTemperature >= 24 && currentTemperature <= 26)
      return Icons.check_circle;
    if (currentTemperature < 28) return Icons.warning_amber;
    return Icons.error;
  }

  String _getMarineAdvice() {
    if (currentTemperature < 24) {
      return 'Temperatura troppo bassa per la maggior parte dei coralli';
    } else if (currentTemperature >= 24 && currentTemperature <= 26) {
      return 'Temperatura ideale per coralli e pesci tropicali';
    } else if (currentTemperature > 26 && currentTemperature < 28) {
      return 'Attenzione: stress per coralli sensibili';
    } else if (currentTemperature >= 28 && currentTemperature < 30) {
      return 'Temperatura alta: rischio per i coralli';
    } else {
      return 'PERICOLO: Sbiancamento coralli imminente!';
    }
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icona termometro a sinistra
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _getTemperatureColor().withOpacity(0.2),
                  _getTemperatureColor().withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.thermostat,
              size: 64,
              color: _getTemperatureColor(),
            ),
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
                      "Temperatura",
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
                      color: _getTemperatureColor(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "${currentTemperature.toStringAsFixed(1)}°C",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _getTemperatureColor(),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getTemperatureColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getTemperatureStatus(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getTemperatureColor(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
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
                if (targetTemperature != null) ...[
                  const SizedBox(height: 8),
                  _buildInfoChip(
                    'Target',
                    '${targetTemperature!.toStringAsFixed(1)}°C',
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
          ),
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
