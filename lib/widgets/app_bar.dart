import 'package:flutter/material.dart';

class CustomTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: const Text(''), 
      automaticallyImplyLeading: false,
      actions: [
        _circleIcon(Icons.factory),
        const SizedBox(width: 12),
        _circleIcon(Icons.mail),
        const SizedBox(width: 12),
        _notificationIconWithBadge(3),
        const SizedBox(width: 12),
        _circleIcon(Icons.menu),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _circleIcon(IconData icon) {
    return CircleAvatar(
      backgroundColor: const Color(0xFF1C1C1C),
      radius: 20,
      child: Icon(icon, color: Colors.lightGreen, size: 20),
    );
  }

  Widget _notificationIconWithBadge(int count) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _circleIcon(Icons.notifications),
        Positioned(
          top: 6,
          right: 4,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
            child: Center(
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
