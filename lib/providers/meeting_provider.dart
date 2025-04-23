import 'package:flutter/material.dart';
import '../models/meeting_model.dart';
import '../services/api_services.dart';

class MeetingProvider with ChangeNotifier {
  List<MeetingModel> _meetings = [];
  DateTime _selectedDate = DateTime.now();

  List<MeetingModel> get meetings => _meetings;
  DateTime get selectedDate => _selectedDate;

  List<MeetingModel> get meetingsForSelectedDate {
    return _meetings.where((m) {
      return m.date.year == _selectedDate.year &&
          m.date.month == _selectedDate.month &&
          m.date.day == _selectedDate.day;
    }).toList();
  }

  Future<void> loadMeetings() async {
    _meetings = await ApiService.fetchMeetings();
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
