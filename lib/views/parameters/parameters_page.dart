import 'package:acquariumfe/views/parameters/parameters_view.dart';
import 'package:flutter/material.dart';

class ParametersPage extends StatelessWidget {
  const ParametersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2d2d2d),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3a3a3a),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Parametri',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: ParametersView(),
      ),
    );
  }
}
