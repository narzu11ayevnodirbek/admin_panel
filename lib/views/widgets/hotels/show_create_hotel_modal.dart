import 'package:admin_panel/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/models/hotel_model.dart';
import 'package:admin_panel/viewmodels/hotel_viewmodel.dart';

Future<void> showCreateHotelModal(
  BuildContext context,
  HotelViewmodel viewmodel,
) async {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final priceController = TextEditingController();
  final firstImageController = TextEditingController();
  final secondImageController = TextEditingController();
  final thirdImageController = TextEditingController();
  final fourthImageController = TextEditingController();
  final facilities = ['Wifi', 'Nonushta', 'TV', 'Basseyn'];
  final types = ['Standart', 'Lux', 'Premium'];

  final selectedFacilities = <String>{};
  final selectedTypes = <String>{};

  List<String> newImages = [];

  await showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text(
          "Create Hotel",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: firstImageController,
                    decoration: const InputDecoration(
                      labelText: 'First image',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: secondImageController,
                    decoration: const InputDecoration(
                      labelText: 'Second image',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: thirdImageController,
                    decoration: const InputDecoration(
                      labelText: 'Third image',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: fourthImageController,
                    decoration: const InputDecoration(
                      labelText: 'Fourth image',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Facilities",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...facilities.map(
                    (f) => CheckboxListTile(
                      title: Text(f),
                      value: selectedFacilities.contains(f),
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            selectedFacilities.add(f);
                          } else {
                            selectedFacilities.remove(f);
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Room Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...types.map(
                    (t) => CheckboxListTile(
                      title: Text(t),
                      value: selectedTypes.contains(t),
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            selectedTypes.add(t);
                          } else {
                            selectedTypes.remove(t);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              newImages.addAll([
                firstImageController.text,
                secondImageController.text,
                thirdImageController.text,
                fourthImageController.text,
              ]);
              final newHotel = HotelModel(
                name: nameController.text,
                description: descriptionController.text,
                address: addressController.text,
                price: int.tryParse(priceController.text) ?? 0,
                facilities: selectedFacilities.toList(),
                images: newImages,
                types: selectedTypes.toList(),
                rating: 0.0,
                reviews: <String, ReviewModel>{},
              );

              await viewmodel.createHotelToFirebase(newHotel);
              Navigator.of(ctx).pop();
            },
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}
