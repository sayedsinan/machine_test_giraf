import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/meeting_provider.dart';
import '../models/meeting_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MeetingProvider>(context, listen: false).loadMeetings();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MeetingProvider>(context);
    final meetings = provider.meetings;
    final selectedDate = provider.selectedDate;
    final meetingsForDay = provider.meetingsForSelectedDate;

    return Scaffold(
      appBar: AppBar(
    
        actions: [Icon(Icons.abc), Icon(Icons.abc), Icon(Icons.abc)],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: selectedDate,
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            onDaySelected: (selected, focused) {
              provider.selectDate(selected);
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) {
                final meetingsForDay =
                    meetings
                        .where(
                          (m) =>
                              m.date.year == day.year &&
                              m.date.month == day.month &&
                              m.date.day == day.day,
                        )
                        .toList();

                if (meetingsForDay.isEmpty) return null;

                final today = DateTime.now();
                final isToday = isSameDay(day, today);
                final isPast = day.isBefore(
                  DateTime(today.year, today.month, today.day),
                );
                final isFuture = day.isAfter(today);

                Color bgColor = Colors.transparent;
                if (isToday)
                  bgColor = Colors.yellow;
                else if (isPast)
                  bgColor = Colors.grey.shade300;
                else if (isFuture)
                  bgColor = Colors.green.shade300;

                return Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text('${day.day}'),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Meetings on selected day:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: meetingsForDay.length,
              itemBuilder: (context, index) {
                final meeting = meetingsForDay[index];
                return ListTile(
                  leading:
                      meeting.conflicted
                          ? const Icon(Icons.warning, color: Colors.red)
                          : const Icon(Icons.event),
                  title: Text(meeting.title),
                  subtitle: Text(meeting.date.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
