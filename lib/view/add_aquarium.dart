import 'package:flutter/material.dart';

class AddAquarium extends StatefulWidget {
  const AddAquarium({super.key});

  @override
  State<AddAquarium> createState() => _AddAquariumState();
}

class _AddAquariumState extends State<AddAquarium> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _volumeController = TextEditingController();
  String _selectedType = 'Marino';

  @override
  void dispose() {
    _nameController.dispose();
    _volumeController.dispose();
    super.dispose();
  }

  void _saveAquarium() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implementare il salvataggio dell'acquario
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Acquario aggiunto con successo!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
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
          title: const Text('Nuovo Acquario'),
          backgroundColor: const Color.fromARGB(255, 126, 173, 255),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveAquarium,
              tooltip: 'Salva',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card con form
                Container(
                  padding: const EdgeInsets.all(24),
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
                      // Titolo
                      Row(
                        children: [
                          Icon(
                            Icons.water,
                            color: Colors.blue[700],
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Informazioni Acquario',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Nome
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nome Acquario',
                          hintText: 'es. Reef Principale',
                          prefixIcon: const Icon(Icons.label),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Inserisci un nome per l\'acquario';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Volume
                      TextFormField(
                        controller: _volumeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Volume (Litri)',
                          hintText: 'es. 200',
                          prefixIcon: const Icon(Icons.straighten),
                          suffixText: 'L',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Inserisci il volume dell\'acquario';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Inserisci un numero valido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Tipo acquario
                      Text(
                        'Tipo di Acquario',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _buildTypeChip('Marino', Icons.waves),
                          _buildTypeChip('Dolce', Icons.water_drop),
                          _buildTypeChip('Salmastro', Icons.water),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Note aggiuntive
                      TextFormField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Note (opzionale)',
                          hintText: 'Aggiungi eventuali note...',
                          prefixIcon: const Icon(Icons.notes),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Pulsante salva
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: _saveAquarium,
                    icon: const Icon(Icons.add_circle),
                    label: const Text(
                      'Aggiungi Acquario',
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
      ),
    );
  }

  Widget _buildTypeChip(String type, IconData icon) {
    final isSelected = _selectedType == type;
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected ? Colors.white : Colors.blue[700],
          ),
          const SizedBox(width: 8),
          Text(type),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedType = type;
        });
      },
      selectedColor: Colors.blue[700],
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey[800],
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      checkmarkColor: Colors.white,
    );
  }
}
