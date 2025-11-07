import 'package:flutter/material.dart';
import 'package:acquariumfe/widgets/components/thermometer.dart';
import 'package:acquariumfe/widgets/components/ph.dart';
import 'package:acquariumfe/widgets/components/salinity.dart';
import 'package:acquariumfe/widgets/components/orp.dart';
import 'package:acquariumfe/widgets/components/manual_parameters.dart';

class ParametersView extends StatelessWidget {
  const ParametersView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Thermometer(currentTemperature: 25.3, targetTemperature: 25.0),
          const SizedBox(height: 16),
          const PhMeter(currentPh: 8.2, targetPh: 8.2),
          const SizedBox(height: 16),
          const SalinityMeter(currentSalinity: 1.024, targetSalinity: 1.024),
          const SizedBox(height: 16),
          const OrpMeter(currentOrp: 350, targetOrp: 360),
          const SizedBox(height: 16),
          const ManualParametersWidget(),
        ],
      ),
    );
  }
}
