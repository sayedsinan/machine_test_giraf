import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meeting_model.dart';

class ApiService {
  static const String _baseUrl =
      'https://yescrm.bigleap.tech/api/meeting-calender-list?year=2025&month=4';
  static const String _token =
      '62|ETMxY74TJrk98K055rI3k3FjGsBFJqnVlQH1MItAb6f42810';

  static Future<List<MeetingModel>> fetchMeetings() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List meetings = data['data'];
      return meetings
          .map((meeting) => MeetingModel.fromJson(meeting))
          .toList();
    } else {
      throw Exception('Failed to load meetings');
    }
  }
}
