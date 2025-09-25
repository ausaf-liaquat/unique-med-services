import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ums_staff/screens/other/models/notification.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

import 'card.dart';

class NotificationCard extends StatelessWidget {
  late NotificationModel notification;
  NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: AppCard(
          padding: const EdgeInsets.all(20),
          radius: BorderRadius.circular(16),
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Row(
          children: [
          // Notification icon with modern design
          Container(
          width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                  HexColor('#58BDEA').withOpacity(0.8),
              HexColor('#58BDEA').withOpacity(0.6)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.notifications_active_outlined,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unique Med Services',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _formatRelativeTime(DateTime.parse(notification.createdAt)),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Status indicator (if read field exists)
        if (true)
    Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: false
            ? Colors.grey[400]
            : HexColor('#58BDEA'),
        shape: BoxShape.circle,
      ),
    ),
    ],
    ),
    const SizedBox(height: 16),

    // Notification title
    Text(
    notification.title,
    style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Colors.grey[800],
    height: 1.4,
    ),
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
    ),

    const SizedBox(height: 16),

    // Date and time section
    Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
    color: Colors.grey[50],
    borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Row(
    children: [
    Icon(
    Icons.access_time_outlined,
    color: Colors.grey[500],
    size: 14,
    ),
    const SizedBox(width: 6),
    Text(
    DateFormat('HH:mm').format(DateTime.parse(notification.createdAt)),
    style: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.grey[700],
    ),
    ),
    ],
    ),
    Row(
    children: [
    Icon(
    Icons.calendar_today_outlined,
    color: Colors.grey[500],
    size: 14,
    ),
    const SizedBox(width: 6),
    Text(
    DateFormat('MMM dd, yyyy').format(DateTime.parse(notification.createdAt)),
    style: TextStyle(
    fontSize: 12,
    color: Colors.grey[600],
    ),
    ),
    ],
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    );
  }

  String _formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inHours < 1) return '${difference.inMinutes}m ago';
    if (difference.inDays < 1) return '${difference.inHours}h ago';
    if (difference.inDays == 1) return 'Yesterday';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    if (difference.inDays < 30) return '${difference.inDays ~/ 7}w ago';

    return DateFormat('MMM dd').format(dateTime);
  }
}