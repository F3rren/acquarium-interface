import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
          'Profilo',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_outline, size: 80, color: Colors.white24),
                SizedBox(height: 20),
                Text(
                  'Profilo Acquario',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Sezione in sviluppo',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
