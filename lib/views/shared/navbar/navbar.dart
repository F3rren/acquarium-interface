import 'package:acquariumfe/routes/routes_name.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Aquarium App',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.2,
        ),
      ),
      backgroundColor: const Color(0xFF2d2d2d),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, size: 24),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, size: 24),
          onPressed: () {},
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.add_circle_outline, size: 24),
          tooltip: 'Gestisci Acquari',
          color: const Color(0xFF3a3a3a),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          onSelected: (value) {
            switch (value) {
              case 'add':
                Navigator.pushNamed(context, RouteNames.addAquarium);
                break;
              case 'edit':
                Navigator.pushNamed(context, RouteNames.editAquarium);
                break;
              case 'delete':
                Navigator.pushNamed(context, RouteNames.deleteAquarium);
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              value: 'add',
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF34d399).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add_circle, color: Color(0xFF34d399), size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Text('Aggiungi Vasca', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: 'edit',
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF60a5fa).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.edit, color: Color(0xFF60a5fa), size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Text('Modifica Vasca', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: 'delete',
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFef4444).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.delete, color: Color(0xFFef4444), size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Text('Elimina Vasca', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
