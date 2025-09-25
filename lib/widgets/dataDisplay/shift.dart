import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ums_staff/screens/shift/models.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/row_item.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

class JobShift extends StatelessWidget {
  final ShiftModel shift;
  final bool accept;
  final bool compact;
  final bool showCallOutButton;

  const JobShift({
    super.key,
    required this.shift,
    this.accept = false,
    this.compact = false,
    this.showCallOutButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return compact ? _buildCompactLayout(context) : _buildDetailedLayout(context);
  }

  Widget _buildDetailedLayout(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    List<String> shiftNote = _parseShiftNotes();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section
        _buildHeaderSection(shiftNote, context),

        const SizedBox(height: 20),

        // Details Grid
        _buildDetailsGrid(),

        const SizedBox(height: 16),

        // Additional Information
        if (shift.additionalComments?.isNotEmpty == true)
          _buildAdditionalComments(),

        // Call Out Button
        if (showCallOutButton) _buildCallOutButton(),
      ],
    );
  }

  Widget _buildCompactLayout(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    List<String> shiftNote = _parseShiftNotes();

    return Row(
      children: [
        // Date Badge
        Container(
          width: 60,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                _getDayAbbreviation(shift.date),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
              Text(
                _getDayNumber(shift.date),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shift.title.isNotEmpty ? shift.title : 'Shift Offer',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 4),

              if (shiftNote.isNotEmpty)
                Text(
                  shiftNote.join(', '),
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

              const SizedBox(height: 6),

              Row(
                children: [
                  Icon(Icons.access_time, size: 12,
                      color: colorScheme.onSurface.withOpacity(0.5)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      shift.shiftHour,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Rate Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '\$${shift.ratePerHour}/h',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.green.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection(List<String> shiftNote, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AppTypography(
                text: shift.title.isNotEmpty ? shift.title : 'Shift Offer',
                size: 20,
                weight: FontWeight.w700,
                color: colorScheme.onSurface,
                // maxLines: 2,
              ),
            ),
            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Available',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        if (shiftNote.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: shiftNote.map((note) => _buildNoteChip(note, context)).toList(),
          ),
      ],
    );
  }

  Widget _buildDetailsGrid() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildDetailItem(
          Icons.medical_services_outlined,
          'Clinician Type',
          shift.clinicianType.isNotEmpty ? shift.clinicianType : 'Not specified',
          Colors.blue,
        ),
        _buildDetailItem(
          Icons.attach_money_outlined,
          'Rate per Hour',
          '\$${shift.ratePerHour}',
          Colors.green,
        ),
        _buildDetailItem(
          Icons.access_time_outlined,
          'Shift Hours',
          shift.shiftHour,
          Colors.orange,
        ),
        _buildDetailItem(
          Icons.location_on_outlined,
          'Location',
          shift.shiftLocation.isNotEmpty ? shift.shiftLocation : 'To be determined',
          Colors.red,
        ),
        _buildDetailItem(
          Icons.calendar_today_outlined,
          'Date',
          shift.date,
          Colors.purple,
        ),
        if (shift.totalAmount.isNotEmpty)
          _buildDetailItem(
            Icons.payments_outlined,
            'Total Amount',
            '\$${shift.totalAmount}',
            Colors.teal,
          ),
      ],
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value, Color color) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 16, color: color),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalComments() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.note_outlined, size: 16, color: Colors.blue.shade600),
              const SizedBox(width: 8),
              Text(
                'Additional Comments',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            shift.additionalComments!,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallOutButton() {
    return Column(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: 140,
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFFE25C55),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.block_outlined, size: 16),
            label: const Text(
              'Call Out',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoteChip(String note, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Color chipColor = _getNoteColor(note);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Text(
        note,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: chipColor,
        ),
      ),
    );
  }

  Color _getNoteColor(String note) {
    final noteColors = {
      'PM': Colors.orange,
      'LATE CALL': Colors.red,
      'URGENT': Colors.redAccent,
      'EMERGENCY': Colors.deepOrange,
      'SPECIAL': Colors.purple,
      'NEW': Colors.green,
    };

    return noteColors[note.toUpperCase()] ?? Colors.grey;
  }

  List<String> _parseShiftNotes() {
    if (shift.shiftNote != null && shift.shiftNote!.isNotEmpty) {
      try {
        return (jsonDecode(shift.shiftNote.toString()) as List<dynamic>)
            .map((e) => e.toString())
            .toList();
      } catch (e) {
        return [shift.shiftNote!];
      }
    }
    return [];
  }

  String _getDayAbbreviation(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      switch (date.weekday) {
        case 1: return 'MON';
        case 2: return 'TUE';
        case 3: return 'WED';
        case 4: return 'THU';
        case 5: return 'FRI';
        case 6: return 'SAT';
        case 7: return 'SUN';
        default: return 'MON';
      }
    } catch (e) {
      return 'MON';
    }
  }

  String _getDayNumber(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return date.day.toString();
    } catch (e) {
      return '1';
    }
  }
}