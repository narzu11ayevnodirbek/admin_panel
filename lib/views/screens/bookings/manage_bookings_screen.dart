import 'package:admin_panel/models/booking_model.dart';
import 'package:flutter/material.dart';

class ManageBookingsScreen extends StatelessWidget {
  final List<BookingModel> bookings;

  const ManageBookingsScreen({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text("User Bookings")),
      body:
          bookings.isEmpty
              ? Center(child: Text("Bookinglar mavjud emas."))
              : ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return Card(
                    margin: EdgeInsets.all(12),
                    child: ListTile(
                      title: Text(booking.name ?? "No name"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (booking.description != null)
                            Text("Tavsif: ${booking.description}"),
                          if (booking.type != null)
                            Text("Turi: ${booking.type}"),
                          if (booking.startDate != null)
                            Text("Boshlanish: ${booking.startDate}"),
                          if (booking.endDate != null)
                            Text("Tugash: ${booking.endDate}"),
                          if (booking.totalPrice != null)
                            Text("Narxi: \$${booking.totalPrice}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
