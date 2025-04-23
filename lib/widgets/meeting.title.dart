import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/meeting_model.dart';
import '../providers/meeting_provider.dart';

class MeetingDetailCard extends StatelessWidget {
  final MeetingModel meeting;
  const MeetingDetailCard({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
     final provider = Provider.of<MeetingProvider>(context);
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
                provider.formatDateWithDay(meeting.date),
                style: const TextStyle(
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
  }


}
