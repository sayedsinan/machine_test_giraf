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
    return MeetingModel(
      title: json['title'] ?? 'meeting',
      date: DateTime.parse(json['date']),
      conflicted: json['conflicted'] ?? false,
    );
  }
}
