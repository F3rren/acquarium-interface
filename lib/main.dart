import 'package:acquariumfe/routes/app_routes.dart';
import 'package:acquariumfe/views/home/acquariums_view.dart';
import 'package:acquariumfe/views/shared/navbar/navbar.dart';
import 'package:acquariumfe/services/notification_service.dart';
import 'package:acquariumfe/services/alert_manager.dart';
import 'package:acquariumfe/models/notification_settings.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inizializza il servizio notifiche
  await NotificationService().initialize();
  
  // Inizializza l'alert manager con impostazioni di default
  AlertManager().initialize(NotificationSettings(
    enabledAlerts: true,
    enabledMaintenance: true,
    enabledDaily: false,
  ));
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aquarium HomePage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF60a5fa),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF1a1a1a),
        cardColor: const Color(0xFF2a2a2a),
      ),
      home: const HomePage(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0f0f0f),
            Color(0xFF1a1a1a),
            Color(0xFF2d2d2d),
            Color(0xFF1e1e1e),
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: Navbar(),
        body: AquariumView(),
      ),
    );
  }
}
