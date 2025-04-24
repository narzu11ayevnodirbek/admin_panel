import 'package:admin_panel/viewmodels/hotel_viewmodel.dart';
import 'package:admin_panel/views/widgets/hotels/edit_hotel_modal.dart';
import 'package:admin_panel/views/widgets/hotels/show_create_hotel_modal.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ManageHotelsScreen extends StatefulWidget {
  const ManageHotelsScreen({super.key});

  @override
  State<ManageHotelsScreen> createState() => _ManageHotelsScreenState();
}

class _ManageHotelsScreenState extends State<ManageHotelsScreen> {
  final hotelViewModel = HotelViewmodel();
  bool isLoading = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    await hotelViewModel.getHotelsFromRemote();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text("Hotels"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showCreateHotelModal(context, hotelViewModel);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: hotelViewModel.remoteHotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotelViewModel.remoteHotels[index];

                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CarouselSlider(
                            items:
                                hotel.images.map((e) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      e,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  );
                                }).toList(),
                            options: CarouselOptions(
                              height: 300,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                currentIndex = index;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          hotel.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(hotel.description),
                        SizedBox(height: 16),
                        Row(
                          spacing: 10,
                          children: [
                            Icon(Icons.location_on, color: Colors.grey),
                            Text(hotel.address),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Facilities:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              hotel.facilities.map((facility) {
                                return Chip(
                                  label: Text(facility),
                                  shape: StadiumBorder(),
                                );
                              }).toList(),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Room types:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              hotel.types.map((types) {
                                return Chip(
                                  label: Text(types),
                                  backgroundColor: Colors.green.shade100,
                                  shape: StadiumBorder(
                                    side: BorderSide(
                                      color: Colors.green.shade100,
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Price: \$${hotel.price}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Rating: ${hotel.rating}⭐️",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FilledButton(
                              onPressed: () async {
                                await showEditHotelModal(
                                  context,
                                  hotel,
                                  hotelViewModel,
                                );
                                setState(() {});
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: Color(0xFF4CAF50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "EDIT",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            FilledButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        "DELETE",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Text(
                                        "Are you sure you want to delete ${hotel.name} hotel?",
                                      ),
                                      actions: [
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        FilledButton(
                                          onPressed: () async {
                                            await hotelViewModel
                                                .deleteHotelsFromRemote(
                                                  hotel.id!,
                                                );
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          child: Text("Delete"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "DELETE",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
