import 'package:flutter/material.dart';

class EditAquarium extends StatefulWidget {
  const EditAquarium({super.key});

  @override
  State<EditAquarium> createState() => _EditAquariumState();
}

class _EditAquariumState extends State<EditAquarium> {
  // TODO: Recuperare lista acquari dal backend/database
  final List<Map<String, dynamic>> _aquariums = [
    {'id': 1, 'name': 'Reef Principale', 'volume': 200, 'type': 'Marino'},
    {'id': 2, 'name': 'Acquario Tropicale', 'volume': 150, 'type': 'Dolce'},
  ];

  Map<String, dynamic>? _selectedAquarium;

  void _navigateToEdit() {
    if (_selectedAquarium == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seleziona un acquario da modificare'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // TODO: Navigare alla pagina di modifica con i dati dell'acquario selezionato
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifica Acquario'),
        content: Text('Modifica di: ${_selectedAquarium!['name']}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Chiudi'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3ac3cb), Color(0xFFf85187)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Modifica Vasca'),
          backgroundColor: const Color.fromARGB(255, 126, 173, 255),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
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
                        Icon(Icons.edit, color: Colors.blue[700], size: 28),
                        const SizedBox(width: 12),
                        Text(
                          'Seleziona Acquario',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (_aquariums.isEmpty)
                      const Center(
                        child: Text(
                          'Nessun acquario disponibile',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    else
                      ..._aquariums.map((aquarium) {
                        final isSelected = _selectedAquarium == aquarium;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedAquarium = aquarium;
                              });
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue[50]
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.blue[700]!
                                      : Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.water,
                                    color: isSelected
                                        ? Colors.blue[700]
                                        : Colors.grey[600],
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          aquarium['name'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? Colors.blue[900]
                                                : Colors.grey[800],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${aquarium['volume']}L - ${aquarium['type']}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.blue[700],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _navigateToEdit,
                  icon: const Icon(Icons.edit),
                  label: const Text(
                    'Modifica Selezionato',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
