import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/medicine.dart';
import '../providers/medicine_provider.dart';

class MedicineTile extends StatelessWidget {
  final Medicine medicine;

  const MedicineTile({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(medicine.name),
        subtitle: Text(medicine.dose),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Time display
            Text(DateFormat.jm().format(medicine.time)),

            const SizedBox(width: 10),

            // Delete button
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Confirm deletion
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Delete Medicine'),
                    content: Text(
                        'Are you sure you want to delete "${medicine.name}"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          context
                              .read<MedicineProvider>()
                              .deleteMedicine(medicine);
                          Navigator.pop(context);
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
