import 'package:acquariumfe/components/thermometer.dart';
import 'package:acquariumfe/components/ph.dart';
import 'package:acquariumfe/components/salinity.dart';
import 'package:acquariumfe/components/orp.dart';
import 'package:acquariumfe/components/manual_parameters.dart';
import 'package:flutter/material.dart';

class AquariumDetails extends StatefulWidget {

  const AquariumDetails({super.key});

  @override
  State<StatefulWidget> createState()  => _AquariumDetailsState();

}

class _AquariumDetailsState extends State<AquariumDetails> {
  double currentTemperature = 25.0;
  double currentPh = 8.2;
  double currentSalinity = 1.024;
  double currentOrp = 350.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aquarium Details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF3ac3cb), Color(0xFFf85187)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Termometro con informazioni complete
                Thermometer(
                  currentTemperature: currentTemperature,
                  targetTemperature: 25.0,
                  lastUpdated: DateTime.now().subtract(const Duration(minutes: 5)),
                  deviceName: 'Sensore Principale',
                ),
                
                const SizedBox(height: 20),
                
                // pH Meter
                PhMeter(
                  currentPh: currentPh,
                  targetPh: 8.2,
                  lastUpdated: DateTime.now().subtract(const Duration(minutes: 3)),
                  deviceName: 'pH Controller',
                ),
                
                const SizedBox(height: 20),
                
                // Salinità
                SalinityMeter(
                  currentSalinity: currentSalinity,
                  targetSalinity: 1.024,
                  lastUpdated: DateTime.now().subtract(const Duration(minutes: 10)),
                  deviceName: 'Conduttivimetro',
                ),
                
                const SizedBox(height: 20),
                
                // ORP/Redox
                OrpMeter(
                  currentOrp: currentOrp,
                  targetOrp: 350.0,
                  lastUpdated: DateTime.now().subtract(const Duration(minutes: 7)),
                  deviceName: 'Sonda ORP',
                ),
                
                const SizedBox(height: 20),
                
                // Parametri manuali
                const ManualParametersWidget(),
                
                const SizedBox(height: 20),
                
                // Controlli debug (da rimuovere in produzione)
                _buildDebugControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDebugControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Controlli Test (Debug)',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => currentTemperature = (currentTemperature - 0.5).clamp(15.0, 35.0)),
                child: const Text('T -'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => currentTemperature = (currentTemperature + 0.5).clamp(15.0, 35.0)),
                child: const Text('T +'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => currentPh = (currentPh - 0.1).clamp(7.0, 9.0)),
                child: const Text('pH -'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => currentPh = (currentPh + 0.1).clamp(7.0, 9.0)),
                child: const Text('pH +'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => currentSalinity = (currentSalinity - 0.001).clamp(1.015, 1.035)),
                child: const Text('Sal -'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => currentSalinity = (currentSalinity + 0.001).clamp(1.015, 1.035)),
                child: const Text('Sal +'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => currentOrp = (currentOrp - 10).clamp(150.0, 550.0)),
                child: const Text('ORP -'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => currentOrp = (currentOrp + 10).clamp(150.0, 550.0)),
                child: const Text('ORP +'),
              ),
            ],
          ),
        ],
      ),
    );
  }


}