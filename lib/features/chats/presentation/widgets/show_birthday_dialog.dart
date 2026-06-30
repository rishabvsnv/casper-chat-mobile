import 'package:flutter/material.dart';

Future<void> showBirthdayDialog(BuildContext context) async {
  DateTime? selectedDate;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Row(
              children: [
                Icon(Icons.cake_rounded, color: Colors.orange),
                SizedBox(width: 8),
                Text('Add Your Birthday'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Let your contacts know when you are celebrating 🎉',
                ),

                const SizedBox(height: 20),

                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(DateTime.now().year - 20),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      setDialogState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      selectedDate == null
                          ? 'Select Birthday'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),

              FilledButton(
                onPressed: selectedDate == null
                    ? null
                    : () {
                        // Save birthday here

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Birthday saved successfully 🎂'),
                          ),
                        );
                      },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
    },
  );
}
