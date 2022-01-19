class Booking {
  final String uid;
  Booking({this.uid});
}

class BookingData {
  final String uid;
  final String selectedBookingdate;
  final String selectedSportPlace;
  final String selectedTimeSlot;

  BookingData(
      {this.uid,
      this.selectedBookingdate,
      this.selectedSportPlace,
      this.selectedTimeSlot});
}
