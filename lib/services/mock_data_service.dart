import 'dart:async';
import 'dart:math';
import 'package:acquariumfe/models/notification_settings.dart';
import 'package:acquariumfe/services/alert_manager.dart';

class MockDataService {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();

  final Random _random = Random();
  Timer? _monitoringTimer;
  bool _isMonitoring = false;

  // Parametri mock correnti
  final Map<String, double> _currentParameters = {
    'temperature': 25.0,
    'ph': 8.2,
    'salinity': 1.024,
    'orp': 400.0,
    'calcium': 425.0,
    'magnesium': 1300.0,
    'kh': 10.0,
    'nitrate': 5.0,
    'phosphate': 0.05,
  };

  /// Ottiene i parametri correnti
  Map<String, double> getCurrentParameters() => Map.from(_currentParameters);

  /// Simula parametro fuori range per testare alert (TROPPO ALTO)
  void simulateOutOfRangeParameter(String parameter) {
    switch (parameter) {
      case 'temperature':
        _currentParameters['temperature'] = 28.5; // ALTO: Fuori range (24-26)
        break;
      case 'ph':
        _currentParameters['ph'] = 8.8; // ALTO: Fuori range (8.0-8.4)
        break;
      case 'salinity':
        _currentParameters['salinity'] = 1.030; // ALTO: Fuori range (1.023-1.026)
        break;
      case 'orp':
        _currentParameters['orp'] = 500.0; // ALTO: Fuori range (300-400)
        break;
      case 'calcium':
        _currentParameters['calcium'] = 500.0; // ALTO: Fuori range (400-450)
        break;
      case 'magnesium':
        _currentParameters['magnesium'] = 1400.0; // ALTO: Fuori range (1250-1350)
        break;
      case 'kh':
        _currentParameters['kh'] = 15.0; // ALTO: Fuori range (7-9)
        break;
      case 'nitrate':
        _currentParameters['nitrate'] = 25.0; // ALTO: Fuori range (0-10)
        break;
      case 'phosphate':
        _currentParameters['phosphate'] = 0.5; // ALTO: Fuori range (0.03-0.1)
        break;
    }
  }

  /// Simula parametro TROPPO BASSO
  void simulateLowParameter(String parameter) {
    switch (parameter) {
      case 'temperature':
        _currentParameters['temperature'] = 22.0; // BASSO: sotto 24°C
        break;
      case 'ph':
        _currentParameters['ph'] = 7.5; // BASSO: sotto 8.0
        break;
      case 'salinity':
        _currentParameters['salinity'] = 1.020; // BASSO: sotto 1.023
        break;
      case 'orp':
        _currentParameters['orp'] = 250.0; // BASSO: sotto 300mV
        break;
      case 'calcium':
        _currentParameters['calcium'] = 350.0; // BASSO: sotto 400ppm
        break;
      case 'magnesium':
        _currentParameters['magnesium'] = 1100.0; // BASSO: sotto 1250ppm
        break;
      case 'kh':
        _currentParameters['kh'] = 5.0; // BASSO: sotto 7dKH
        break;
      case 'nitrate':
        _currentParameters['nitrate'] = 0.0; // OK (nitrati bassi vanno bene)
        break;
      case 'phosphate':
        _currentParameters['phosphate'] = 0.01; // BASSO: sotto 0.03ppm
        break;
    }
  }

  /// Resetta tutti i parametri ai valori ottimali
  void resetToOptimalValues() {
    _currentParameters['temperature'] = 25.0;
    _currentParameters['ph'] = 8.2;
    _currentParameters['salinity'] = 1.024;
    _currentParameters['orp'] = 400.0;
    _currentParameters['calcium'] = 425.0;
    _currentParameters['magnesium'] = 1300.0;
    _currentParameters['kh'] = 10.0;
    _currentParameters['nitrate'] = 5.0;
    _currentParameters['phosphate'] = 0.05;
  }

  /// Genera variazione casuale in un parametro
  void randomizeParameter(String parameter) {
    final current = _currentParameters[parameter] ?? 0.0;
    final variation = (_random.nextDouble() - 0.5) * 2; // -1 a +1
    
    switch (parameter) {
      case 'temperature':
        _currentParameters['temperature'] = (current + variation * 0.5).clamp(22.0, 30.0);
        break;
      case 'ph':
        _currentParameters['ph'] = (current + variation * 0.2).clamp(7.0, 9.0);
        break;
      case 'salinity':
        _currentParameters['salinity'] = (current + variation * 0.003).clamp(1.020, 1.030);
        break;
      case 'orp':
        _currentParameters['orp'] = (current + variation * 20).clamp(250.0, 500.0);
        break;
      case 'calcium':
        _currentParameters['calcium'] = (current + variation * 25).clamp(350.0, 500.0);
        break;
      case 'magnesium':
        _currentParameters['magnesium'] = (current + variation * 50).clamp(1100.0, 1400.0);
        break;
      case 'kh':
        _currentParameters['kh'] = (current + variation * 1.5).clamp(6.0, 15.0);
        break;
      case 'nitrate':
        _currentParameters['nitrate'] = (current + variation * 3).clamp(0.0, 30.0);
        break;
      case 'phosphate':
        _currentParameters['phosphate'] = (current + variation * 0.05).clamp(0.0, 0.5);
        break;
    }
  }

  /// Avvia monitoraggio automatico con check periodici
  void startAutoMonitoring({Duration interval = const Duration(seconds: 30)}) {
    if (_isMonitoring) return;

    _isMonitoring = true;
    _monitoringTimer = Timer.periodic(interval, (timer) async {
      // Randomizza leggermente alcuni parametri
      if (_random.nextBool()) randomizeParameter('temperature');
      if (_random.nextBool()) randomizeParameter('ph');
      
      // Controlla tutti i parametri
      await checkAllParametersWithAlerts();
    });
  }

  /// Ferma il monitoraggio automatico
  void stopAutoMonitoring() {
    _monitoringTimer?.cancel();
    _monitoringTimer = null;
    _isMonitoring = false;
  }

  bool get isMonitoring => _isMonitoring;

  /// Controlla tutti i parametri e invia alert se necessario
  Future<void> checkAllParametersWithAlerts() async {
    final settings = NotificationSettings(); // Usa impostazioni di default
    
    // Temperatura
    await AlertManager().checkParameter(
      name: 'Temperatura',
      value: _currentParameters['temperature']!,
      unit: '°C',
      thresholds: settings.temperature,
    );

    // pH
    await AlertManager().checkParameter(
      name: 'pH',
      value: _currentParameters['ph']!,
      unit: '',
      thresholds: settings.ph,
    );

    // Salinità
    await AlertManager().checkParameter(
      name: 'Salinità',
      value: _currentParameters['salinity']!,
      unit: '',
      thresholds: settings.salinity,
    );

    // ORP
    await AlertManager().checkParameter(
      name: 'ORP',
      value: _currentParameters['orp']!,
      unit: 'mV',
      thresholds: settings.orp,
    );

    // Calcio
    await AlertManager().checkParameter(
      name: 'Calcio',
      value: _currentParameters['calcium']!,
      unit: 'ppm',
      thresholds: settings.calcium,
    );

    // Magnesio
    await AlertManager().checkParameter(
      name: 'Magnesio',
      value: _currentParameters['magnesium']!,
      unit: 'ppm',
      thresholds: settings.magnesium,
    );

    // KH
    await AlertManager().checkParameter(
      name: 'KH',
      value: _currentParameters['kh']!,
      unit: 'dKH',
      thresholds: settings.kh,
    );

    // Nitrati
    await AlertManager().checkParameter(
      name: 'Nitrati',
      value: _currentParameters['nitrate']!,
      unit: 'ppm',
      thresholds: settings.nitrate,
    );

    // Fosfati
    await AlertManager().checkParameter(
      name: 'Fosfati',
      value: _currentParameters['phosphate']!,
      unit: 'ppm',
      thresholds: settings.phosphate,
    );
  }

  /// Controlla un singolo parametro specifico
  Future<void> checkSingleParameter(String parameter) async {
    final settings = NotificationSettings();
    
    switch (parameter) {
      case 'temperature':
        await AlertManager().checkParameter(
          name: 'Temperatura',
          value: _currentParameters['temperature']!,
          unit: '°C',
          thresholds: settings.temperature,
        );
        break;
      case 'ph':
        await AlertManager().checkParameter(
          name: 'pH',
          value: _currentParameters['ph']!,
          unit: '',
          thresholds: settings.ph,
        );
        break;
      case 'salinity':
        await AlertManager().checkParameter(
          name: 'Salinità',
          value: _currentParameters['salinity']!,
          unit: '',
          thresholds: settings.salinity,
        );
        break;
      case 'orp':
        await AlertManager().checkParameter(
          name: 'ORP',
          value: _currentParameters['orp']!,
          unit: 'mV',
          thresholds: settings.orp,
        );
        break;
      case 'calcium':
        await AlertManager().checkParameter(
          name: 'Calcio',
          value: _currentParameters['calcium']!,
          unit: 'ppm',
          thresholds: settings.calcium,
        );
        break;
      case 'magnesium':
        await AlertManager().checkParameter(
          name: 'Magnesio',
          value: _currentParameters['magnesium']!,
          unit: 'ppm',
          thresholds: settings.magnesium,
        );
        break;
      case 'kh':
        await AlertManager().checkParameter(
          name: 'KH',
          value: _currentParameters['kh']!,
          unit: 'dKH',
          thresholds: settings.kh,
        );
        break;
      case 'nitrate':
        await AlertManager().checkParameter(
          name: 'Nitrati',
          value: _currentParameters['nitrate']!,
          unit: 'ppm',
          thresholds: settings.nitrate,
        );
        break;
      case 'phosphate':
        await AlertManager().checkParameter(
          name: 'Fosfati',
          value: _currentParameters['phosphate']!,
          unit: 'ppm',
          thresholds: settings.phosphate,
        );
        break;
    }
  }

  /// Test rapido: simula un alert critico
  Future<void> testCriticalAlert() async {
    simulateOutOfRangeParameter('temperature');
    await checkAllParametersWithAlerts();
  }

  /// Test: programma notifica di manutenzione tra 10 secondi
  Future<void> testMaintenanceNotification() async {
    await AlertManager().scheduleMaintenanceReminders();
  }

  void dispose() {
    stopAutoMonitoring();
  }
}
