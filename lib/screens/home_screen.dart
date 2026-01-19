import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/medicine_provider.dart';
import '../widgets/medicine_tile.dart';
import 'add_medicine_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final medicines = context.watch<MedicineProvider>().medicines;

    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Reminder')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddMedicineScreen()),
          );
        },
      ),
      body: medicines.isEmpty
          ? const Center(
        child: Text(
          'No medicines scheduled',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: medicines.length,
        itemBuilder: (_, i) =>
            MedicineTile(medicine: medicines[i]),
      ),
    );
  }
}
