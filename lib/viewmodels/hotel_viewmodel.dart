import 'package:admin_panel/datasources/hotel_remote_datasources.dart';
import 'package:admin_panel/models/hotel_model.dart';

class HotelViewmodel {
  List<HotelModel> remoteHotels = [];

  final remoteDatasources = HotelRemoteDatasources();

  Future<void> getHotelsFromRemote() async {
    await remoteDatasources.getHotels();
    remoteHotels = remoteDatasources.hotels;
  }

  Future<void> deleteHotelsFromRemote(String hotelId) async {
    try {
      await remoteDatasources.deleteHotel(hotelId);
      remoteHotels.removeWhere((element) => element.id == hotelId);
      print("Hotel deleted: $hotelId");
    } catch (e) {
      print("DeleteHotelsFromRemote error: $e");
    }
  }

  Future<void> updateHotelsFromRemote(
    String hotelId,
    HotelModel updatedHotel,
  ) async {
    await remoteDatasources.updateHotel(hotelId, updatedHotel);
  }

  Future<void> createHotelToFirebase(HotelModel hotel) async {
    await remoteDatasources.createHotel(hotel);

    await remoteDatasources.getHotels();

    remoteHotels = remoteDatasources.hotels;
  }
}
