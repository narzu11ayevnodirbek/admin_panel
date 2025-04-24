import 'package:flutter/material.dart';
import 'package:admin_panel/models/hotel_model.dart';
import 'package:admin_panel/viewmodels/hotel_viewmodel.dart';

Future<void> showEditHotelModal(
  BuildContext context,
  HotelModel hotel,
  HotelViewmodel viewmodel,
) async {
  final nameController = TextEditingController(text: hotel.name);
  final descriptionController = TextEditingController(text: hotel.description);
  final addressController = TextEditingController(text: hotel.address);
  final priceController = TextEditingController(text: hotel.price.toString());

  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text(
          "Edit Hotel",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final updatedHotel = HotelModel(
                id: hotel.id,
                name: nameController.text,
                description: descriptionController.text,
                address: addressController.text,
                facilities: hotel.facilities,
                images: hotel.images,
                reviews: hotel.reviews,
                types: hotel.types,
                price: int.tryParse(priceController.text) ?? hotel.price,
                rating: hotel.rating,
              );

              await viewmodel.updateHotelsFromRemote(hotel.id!, updatedHotel);
              Navigator.of(ctx).pop();
            },
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}
