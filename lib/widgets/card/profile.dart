import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';
import 'package:ums_staff/widgets/card/card.dart';

import '../../screens/profile/model.dart';
import '../../shared/theme/color.dart';
import '../../shared/utils/image_picker.dart';
import '../dataDisplay/row_item.dart';
import '../dataDisplay/typography.dart';

class ProfileCard extends StatelessWidget {
  Profile? profile;
  ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: BorderRadius.circular(24),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Column(
        children: [
          // Header section with profile image and name
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Avatar with modern design
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: HexColor('#6505A3').withOpacity(0.2),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: profile?.imageUrl != null
                        ? CachedNetworkImage(
                      imageUrl: profile!.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.person,
                          color: Colors.grey[400],
                          size: 40,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.person,
                          color: Colors.grey[400],
                          size: 40,
                        ),
                      ),
                    )
                        : Container(
                      color: HexColor('#6505A3').withOpacity(0.1),
                      child: Icon(
                        Icons.person_outline_rounded,
                        color: HexColor('#6505A3'),
                        size: 40,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                // Name and basic info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${profile?.firstName ?? ''} ${profile?.lastName ?? ''}'.trim(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#6505A3'),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Status badge based on shift completion rate
                      _buildStatusBadge(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Shift statistics with modern design
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  HexColor('#6505A3').withOpacity(0.05),
                  HexColor('#6505A3').withOpacity(0.02),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: HexColor('#6505A3').withOpacity(0.1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  value: ((profile?.completedShifts ?? 0) + (profile?.unCompletedShifts ?? 0)).toString(),
                  label: 'Assigned',
                  icon: Icons.assignment_outlined,
                ),
                _buildStatItem(
                  value: (profile?.completedShifts ?? 0).toString(),
                  label: 'Completed',
                  icon: Icons.check_circle_outline,
                ),
                _buildStatItem(
                  value: (profile?.unCompletedShifts ?? 0).toString(),
                  label: 'Pending',
                  icon: Icons.pending_actions_outlined,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Contact information section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _buildInfoRow(
                  icon: Icons.phone_outlined,
                  title: 'Phone Number',
                  value: "+${profile?.phoneNumber ?? 'N/A'}",
                ),
                const SizedBox(height: 16),

                if (profile?.address != null && profile!.address!.isNotEmpty)
                  Column(
                    children: [
                      _buildInfoRow(
                        icon: Icons.location_on_outlined,
                        title: 'Address',
                        value: profile!.address!,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),

                Row(
                  children: [
                    Expanded(
                      child: _buildInfoRow(
                        icon: Icons.apartment_outlined,
                        title: 'State',
                        value: profile?.state ?? 'N/A',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInfoRow(
                        icon: Icons.location_city_outlined,
                        title: 'City',
                        value: profile?.city ?? 'N/A',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _buildInfoRow(
                  icon: Icons.pin_drop_outlined,
                  title: 'ZIP Code',
                  value: profile?.zipCode ?? 'N/A',
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    final totalShifts = (profile?.completedShifts ?? 0) + (profile?.unCompletedShifts ?? 0);
    final completedShifts = profile?.completedShifts ?? 0;

    String statusText;
    Color statusColor;

    if (totalShifts == 0) {
      statusText = 'No shifts assigned';
      statusColor = Colors.grey;
    } else if (completedShifts == totalShifts) {
      statusText = 'All shifts completed';
      statusColor = Colors.green;
    } else if (completedShifts > 0) {
      statusText = 'Partially completed';
      statusColor = Colors.orange;
    } else {
      statusText = 'No shifts completed';
      statusColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: statusColor,
        ),
      ),
    );
  }

  Widget _buildStatItem({required String value, required String label, required IconData icon}) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: HexColor('#6505A3'),
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: HexColor('#6505A3'),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInfoRow({required IconData icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: HexColor('#6505A3').withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: HexColor('#6505A3'),
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileShiftData extends StatelessWidget {
  const ProfileShiftData({super.key, required this.title, required this.quentity});
  final String title;
  final String quentity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HexColor('#F1FAFD'),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: HexColor('#6505A3').withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Text(
            quentity,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: HexColor('#6505A3'),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}