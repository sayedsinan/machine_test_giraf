import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navIcon(Icons.home, 0),
            _navIcon(Icons.handshake, 1),
            _navIcon(Icons.calendar_month, 2, isCenter: true),
            _navIcon(Icons.headset_mic, 3),
            _navIcon(Icons.person, 4),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, int index, {bool isCenter = false}) {
    final isSelected = currentIndex == index;

    return IconButton(
      onPressed: () => onTap(index),
      icon: Icon(
        icon,
        color: isSelected ? Colors.lightGreen : Colors.white54,
        size: isCenter ? 28 : 24,
      ),
    );
  }
}
