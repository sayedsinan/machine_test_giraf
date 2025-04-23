import 'package:flutter/material.dart';
import 'package:machine_test_giraf/widgets/app_bar.dart';
import 'package:machine_test_giraf/widgets/calendar_widget.dart';
import 'package:machine_test_giraf/widgets/meeting.title.dart';
import 'package:machine_test_giraf/widgets/nav_bar.dart';
import 'package:provider/provider.dart';
import '../providers/meeting_provider.dart';
import 'package:intl/intl.dart'; 

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
    final selectedDate = provider.selectedDate;
    final meetingsForDay = provider.meetingsForSelectedDate;

    final String month = DateFormat.MMMM().format(selectedDate);
    final String year = selectedDate.year.toString();

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {

        },
      ),
      backgroundColor: Colors.black,
      appBar: CustomTopAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Meeting List',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.lightGreen,
                      child: IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {
             
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: provider.selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(data: ThemeData.dark(), child: child!);
                  },
                );
                if (picked != null) {
                  provider.selectDate(picked);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        month,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        year,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const MeetingCalendar(),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Text(
                  'Meetings',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Expanded(
                  child: Divider(color: Colors.white, thickness: 1, indent: 10),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: meetingsForDay.length,
              itemBuilder: (context, index) {
                final meeting = meetingsForDay[index];
                return MeetingDetailCard(meeting: meeting);
              },
            ),
          ),
        ],
      ),
    );
  }
}
