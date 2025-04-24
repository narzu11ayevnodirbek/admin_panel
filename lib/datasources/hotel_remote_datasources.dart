import 'dart:convert';

import 'package:admin_panel/models/hotel_model.dart';
import 'package:http/http.dart' as http;

class HotelRemoteDatasources {
  static const baseUrl =
      "https://e-commerce-d13dc-default-rtdb.firebaseio.com/";
  List<HotelModel> hotels = [];

  Future<void> getHotels() async {
    try {
      final url = Uri.parse("$baseUrl/hotel/admin/hotels.json");
      final response = await http.get(url);

      final decodedData = jsonDecode(response.body) as Map<String, dynamic>?;

      if (decodedData != null) {
        hotels =
            decodedData.entries.map((entry) {
              final hotelData = entry.value as Map<String, dynamic>;
              final hotel = HotelModel.fromJson(hotelData);
              hotel.id = entry.key;
              return hotel;
            }).toList();
      }
    } catch (e, s) {
      print("Hotel getda error: $e");
      print(s);
    }
  }

  Future<void> deleteHotel(String hotelId) async {
    try {
      final url = Uri.parse("$baseUrl/hotel/admin/hotels/$hotelId.json");
      await http.delete(url);

      hotels.removeWhere((hotel) => hotel.id == hotelId);
      print("Hotel deleted: $hotelId");
    } catch (e) {
      print("Delete da error: $e");
    }
  }

  Future<void> updateHotel(String hotelId, HotelModel updatedHotel) async {
    try {
      final url = Uri.parse("$baseUrl/hotel/admin/hotels/$hotelId.json");
      await http.patch(url, body: jsonEncode(updatedHotel.toJson()));

      final index = hotels.indexWhere((hotel) => hotel.id == hotelId);
      if (index != -1) {
        hotels[index] = updatedHotel;
        updatedHotel.id = hotelId;
      }
      print("Hotel updated: $hotelId");
    } catch (e) {
      print("Update da error: $e");
    }
  }

  Future<void> createHotel(HotelModel hotel) async {
    try {
      final url = Uri.parse("$baseUrl/hotel/admin/hotels.json");
      final response = await http.post(url, body: jsonEncode(hotel.toJson()));

      final data = jsonDecode(response.body);
      final newHotelId = data['name'];

      final newHotel = hotel.copyWith(id: newHotelId);
      hotels.add(newHotel);
      print("Hotel created: $newHotelId");
    } catch (e) {
      print("Create da error: $e");
    }
  }
}
