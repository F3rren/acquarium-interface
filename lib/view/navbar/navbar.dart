import 'package:acquariumfe/routes/routes_name.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Aquarium App'),
      backgroundColor: const Color.fromARGB(255, 126, 173, 255),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.add),
          tooltip: 'Gestisci Acquari',
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
            const PopupMenuItem<String>(
              value: 'add',
              child: Row(
                children: [
                  Icon(Icons.add_circle, color: Colors.green),
                  SizedBox(width: 12),
                  Text('Aggiungi Vasca'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.blue),
                  SizedBox(width: 12),
                  Text('Modifica Vasca'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 12),
                  Text('Elimina Vasca'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
