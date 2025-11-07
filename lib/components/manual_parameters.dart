import 'package:flutter/material.dart';

class ManualParametersWidget extends StatefulWidget {
  const ManualParametersWidget({super.key});

  @override
  State<ManualParametersWidget> createState() => _ManualParametersWidgetState();
}

class _ManualParametersWidgetState extends State<ManualParametersWidget> {
  // Valori parametri
  double calcium = 420.0;
  double magnesium = 1300.0;
  double kh = 8.0;
  double nitrates = 2.0;
  double phosphates = 0.02;

  DateTime lastCalciumTest = DateTime.now().subtract(const Duration(days: 2));
  DateTime lastMagnesiumTest = DateTime.now().subtract(const Duration(days: 3));
  DateTime lastKhTest = DateTime.now().subtract(const Duration(days: 1));
  DateTime lastNitratesTest = DateTime.now().subtract(
    const Duration(hours: 12),
  );
  DateTime lastPhosphatesTest = DateTime.now().subtract(
    const Duration(days: 1),
  );

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
              Icon(
                Icons.science,
                color: Colors.indigo[600],
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                "Parametri Chimici (Manuale)",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildGroupHeader('Triade (Elementi Maggiori)', Icons.bubble_chart),
          const SizedBox(height: 12),

          // Calcio
          _buildParameterRow(
            'Calcio (Ca)',
            calcium,
            'mg/L',
            400,
            450,
            Icons.layers,
            lastCalciumTest,
            () => _showEditDialog('Calcio', calcium, 'mg/L', 400, 450, (value) {
              setState(() {
                calcium = value;
                lastCalciumTest = DateTime.now();
              });
            }),
          ),
          const SizedBox(height: 12),

          // Magnesio
          _buildParameterRow(
            'Magnesio (Mg)',
            magnesium,
            'mg/L',
            1250,
            1350,
            Icons.auto_awesome,
            lastMagnesiumTest,
            () => _showEditDialog('Magnesio', magnesium, 'mg/L', 1250, 1350, (
              value,
            ) {
              setState(() {
                magnesium = value;
                lastMagnesiumTest = DateTime.now();
              });
            }),
          ),
          const SizedBox(height: 12),

          // KH
          _buildParameterRow(
            'KH (Alcalinità)',
            kh,
            'dKH',
            7,
            9,
            Icons.bar_chart,
            lastKhTest,
            () => _showEditDialog('KH', kh, 'dKH', 7, 9, (value) {
              setState(() {
                kh = value;
                lastKhTest = DateTime.now();
              });
            }),
          ),
          
          const SizedBox(height: 24),
          _buildGroupHeader('Nutrienti', Icons.eco),
          const SizedBox(height: 12),

          // Nitrati
          _buildParameterRow(
            'Nitrati (NO3)',
            nitrates,
            'mg/L',
            0.5,
            5,
            Icons.eco,
            lastNitratesTest,
            () => _showEditDialog('Nitrati', nitrates, 'mg/L', 0.5, 5, (value) {
              setState(() {
                nitrates = value;
                lastNitratesTest = DateTime.now();
              });
            }),
          ),
          const SizedBox(height: 12),

          // Fosfati
          _buildParameterRow(
            'Fosfati (PO4)',
            phosphates,
            'mg/L',
            0.0,
            0.03,
            Icons.water_damage,
            lastPhosphatesTest,
            () => _showEditDialog('Fosfati', phosphates, 'mg/L', 0.0, 0.03, (
              value,
            ) {
              setState(() {
                phosphates = value;
                lastPhosphatesTest = DateTime.now();
              });
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey[600],
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildParameterRow(
    String name,
    double value,
    String unit,
    double minIdeal,
    double maxIdeal,
    IconData icon,
    DateTime lastTest,
    VoidCallback onTap,
  ) {
    final isInRange = value >= minIdeal && value <= maxIdeal;
    final statusColor = isInRange ? Colors.green : Colors.orange;
    final daysAgo = DateTime.now().difference(lastTest).inDays;
    final needsTest = daysAgo > 7;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: needsTest
              ? Colors.orange.withOpacity(0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: statusColor, size: 24),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _showInfoDialog(name),
              child: Icon(
                Icons.info_outline,
                color: Colors.blue[600],
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Range: $minIdeal-$maxIdeal $unit',
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatLastTest(lastTest),
                    style: TextStyle(
                      fontSize: 10,
                      color: needsTest ? Colors.orange[700] : Colors.grey[500],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${value.toStringAsFixed(value < 10 ? 2 : 0)} $unit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isInRange ? 'OK' : 'Fuori range',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Icon(Icons.edit, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }

  String _formatLastTest(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) return 'Testato ${difference.inMinutes}m fa';
    if (difference.inHours < 24) return 'Testato ${difference.inHours}h fa';
    if (difference.inDays == 1) return 'Testato ieri';
    if (difference.inDays < 7) return 'Testato ${difference.inDays} giorni fa';
    return 'Test da fare! (${difference.inDays} giorni fa)';
  }

  void _showInfoDialog(String paramName) {
    String title = '';
    String description = '';
    String importance = '';
    String effects = '';

    switch (paramName) {
      case 'Calcio (Ca)':
        title = 'Calcio (Ca)';
        description =
            'Il calcio è uno degli elementi fondamentali nell’acquario marino di barriera: partecipa alla formazione dello scheletro dei coralli duri (SPS e LPS), dei gusci di molluschi e delle alghe coralline calcaree. Mantenere un livello ottimale di calcio è essenziale per la crescita, la colorazione e la resistenza degli organismi calcifici.';
        importance =
            'Ruolo ecologico:\n• Sintesi strutture calcaree (coralli, molluschi)\n• Ottimizzazione processo di calcificazione\n• Mantenimento pH stabile\n• Supporto funzioni cellulari vitali';
        effects =
            'Deviazioni dal range:\n• Deficit: crescita stentata, fragilità scheletrica, riduzione vitalità coralli\n• Eccesso: precipitazione di carbonati, riduzione trasparenza, possibili squilibri ionici';
        break;
      case 'Magnesio (Mg)':
        title = 'Magnesio (Mg)';
        description =
            'Il magnesio agisce da vero e proprio regolatore nell’equilibrio ionico dell’acqua marina: inibisce la precipitazione del carbonato di calcio e permette la coesistenza stabile tra calcio e alcalinità. È coinvolto nella sintesi clorofilliana, nelle funzioni enzimatiche e nel metabolismo dei coralli.';
        importance =
            'Ruolo ecologico:\n• Mantenimento stabile dei livelli di calcio e KH\n• Prevenzione di precipitazioni non desiderate\n• Supporto agli enzimi cellulari\n• Stimolo alla crescita tessuti molli e calcarei';
        effects =
            'Deviazioni dal range:\n• Deficit: difficoltà nel mantenimento della triade (Ca/KH), rischio di squilibri ionici\n• Eccesso: in rari casi può causare irritazioni ai polipi e squilibri minori';
        break;
      case 'KH (Alcalinità)':
        title = 'KH (Alcalinità)';
        description =
            'L’alcalinità, espressa come KH, rappresenta la quantità di ioni bicarbonato e carbonato presenti in acqua marina. È la principale variabile che mantiene il pH stabile e favorisce la corretta calcificazione. Una corretta alcalinità garantisce un ambiente chimicamente stabile per la crescita dei coralli e previene shock dovuti a sbalzi di pH.';
        importance =
            'Ruolo ecologico:\n• Stabilizzazione chimica del pH\n• Fornitura ioni per calcificazione\n• Buffer contro acidi e sbalzi\n• Supporto al metabolismo fotosintetico delle zooxantelle';
        effects =
            'Deviazioni dal range:\n• Deficit: pH instabile, stress osmotico e metabolico nei coralli\n• Eccesso: precipitazione degli ioni, danni ai tessuti corallini e squilibri generali';
        break;
      case 'Nitrati (NO3)':
        title = 'Nitrati (NO3)';
        description =
            'I nitrati sono il principale prodotto finale della mineralizzazione organica nel ciclo dell’azoto. In quantità controllata rappresentano una risorsa per la crescita dei coralli molli, anemoni e alghe simbionti. Livelli elevati, tuttavia, alterano la qualità dell’acqua, favoriscono la proliferazione algale e possono causare stress invertebrati e coralli sensibili.';
        importance =
            'Ruolo ecologico:\n• Fonte di azoto per coralli molli e zooxantelle\n• Indicatore di efficienza del ciclo biologico\n• Controllo crescita algale\n• Regolazione dell’ecosistema acquatico';
        effects =
            'Deviazioni dal range:\n• Deficit: riduzione pigmentazione coralli molli, crescita limitata\n• Eccesso: alghe infestate, stress organico, rischio di sbiancamento (bleaching)';
        break;
      case 'Fosfati (PO4)':
        title = 'Fosfati (PO4)';
        description =
            'I fosfati sono nutrienti essenziali in tracce, ma devono essere mantenuti ad un livello molto basso in acquario marino. Contribuiscono alle funzioni cellulari delle zooxantelle, ma l’eccesso porta rapidamente alla proliferazione delle alghe, alla perdita di colore dei coralli e all’inibizione della calcificazione degli organismi marini.';
        importance =
            'Ruolo ecologico:\n• Nutriente per zooxantelle e fitoplancton\n• Impatto diretto sulla crescita algale indesiderata\n• Regolazione del metabolismo corallino\n• Indicatore di eccessiva alimentazione o carico organico';
        effects =
            'Deviazioni dal range:\n• Deficit: possibile crescita limitata in alcuni casi rari\n• Eccesso: esplosione alghe invasive, riduzione colore coralli, rischio inibizione calcificazione';
        break;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              Text(
                importance,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                effects,
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

  void _showEditDialog(
    String paramName,
    double currentValue,
    String unit,
    double minIdeal,
    double maxIdeal,
    Function(double) onSave,
  ) {
    final controller = TextEditingController(
      text: currentValue.toStringAsFixed(currentValue < 10 ? 2 : 0),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Aggiorna $paramName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Range ideale: $minIdeal-$maxIdeal $unit',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Valore',
                suffixText: unit,
                border: const OutlineInputBorder(),
              ),
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () {
              final value = double.tryParse(controller.text);
              if (value != null) {
                onSave(value);
                Navigator.pop(context);
              }
            },
            child: const Text('Salva'),
          ),
        ],
      ),
    );
  }
}
