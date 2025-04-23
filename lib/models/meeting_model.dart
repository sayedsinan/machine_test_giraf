class MeetingModel {
  final String title;
  final DateTime date;
  final bool conflicted;

  MeetingModel({
    required this.title,
    required this.date,
    required this.conflicted,
  });

  factory MeetingModel.fromJson(Map<String, dynamic> json) {
  
    var item = json['items'][0]; 

    return MeetingModel(
      title: item['title'] ?? 'Meeting',  
      date: DateTime.parse(json['date']),
      conflicted: item['conflicted'] ?? false,
    );
  }
}
