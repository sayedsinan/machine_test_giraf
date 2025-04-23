import 'package:flutter/material.dart';
import 'package:machine_test_giraf/widgets/app_bar.dart';
import 'package:machine_test_giraf/widgets/calendar_widget.dart';
import 'package:machine_test_giraf/widgets/nav_bar.dart';
import 'package:provider/provider.dart';
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
    final selectedDate = provider.selectedDate;
    final meetingsForDay = provider.meetingsForSelectedDate;

    return Scaffold(
      bottomNavigationBar: 
          CustomBottomNavBar(
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
                          // Add meeting logic
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
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
                    children: [
                      Row(
                        children: [
                          Text(
                            "April ",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "2025 ",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1C),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            meeting.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            TimeOfDay.fromDateTime(
                              meeting.date,
                            ).format(context),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 0.5,
                        height: 16,
                      ),  
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                           provider.formatDateWithDay(meeting.date) 
                            ,style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                            ),
                          ),
                          if (meeting.conflicted)
                            const Icon(
                              Icons.groups_2_rounded,
                              color: Colors.red,
                              size: 20,
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
