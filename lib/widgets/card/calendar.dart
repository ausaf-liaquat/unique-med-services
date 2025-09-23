import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../shared/theme/color.dart';

class CalendarCard extends StatefulWidget {
  final DateTime focusedDay;
  final Function(DateTime) changeDate;
  final Set<String> timeSet;

  const CalendarCard({
    super.key,
    required this.focusedDay,
    required this.changeDate,
    required this.timeSet
  });

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColorScheme().black8,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  color: colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Schedule Calendar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),

          // Calendar
          TableCalendar(
            rowHeight: 48,
            firstDay: DateTime.now().subtract(const Duration(days: 365 * 2)),
            lastDay: DateTime.now().add(const Duration(days: 365 * 2)),
            focusedDay: widget.focusedDay,
            currentDay: widget.focusedDay,
            daysOfWeekHeight: 48,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() => _calendarFormat = format);
            },

            // Custom day builder for timeSet dates
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final dayString = DateFormat('yyyy-MM-dd').format(day);
                final hasTimeSlot = widget.timeSet.contains(dayString);

                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: hasTimeSlot ? colorScheme.primary.withOpacity(0.1) : Colors.transparent,
                    border: Border.all(
                      color: hasTimeSlot ? colorScheme.primary : Colors.transparent,
                      width: hasTimeSlot ? 1.5 : 0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: hasTimeSlot ? FontWeight.w600 : FontWeight.normal,
                        color: hasTimeSlot ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                );
              },
              todayBuilder: (context, day, focusedDay) {
                final dayString = DateFormat('yyyy-MM-dd').format(day);
                final hasTimeSlot = widget.timeSet.contains(dayString);

                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.2),
                    border: Border.all(
                      color: colorScheme.primary,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                );
              },
              selectedBuilder: (context, day, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),

            // Days of week styling
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
              weekendStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colorScheme.error.withOpacity(0.8),
              ),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
              ),
            ),

            // Calendar styling
            calendarStyle: CalendarStyle(
              tablePadding: const EdgeInsets.symmetric(horizontal: 4),
              defaultDecoration: const BoxDecoration(shape: BoxShape.circle),
              weekendDecoration: const BoxDecoration(shape: BoxShape.circle),
              holidayDecoration: const BoxDecoration(shape: BoxShape.circle),
              outsideDecoration: const BoxDecoration(shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.primary, width: 2),
              ),
              defaultTextStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: colorScheme.onSurface.withOpacity(0.8),
              ),
              weekendTextStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: colorScheme.error.withOpacity(0.8),
              ),
              selectedTextStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              todayTextStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),

            // Header styling
            headerStyle: HeaderStyle(
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              headerPadding: const EdgeInsets.symmetric(vertical: 16),
              leftChevronIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
                ),
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
              rightChevronIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
              formatButtonVisible: true,
              formatButtonShowsNext: true,
              formatButtonDecoration: BoxDecoration(
                border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              formatButtonTextStyle: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),

            // Day selection
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                });
                widget.changeDate(selectedDay);
              }
            },
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          ),

          // Legend
          if (widget.timeSet.isNotEmpty) ...[
            const SizedBox(height: 20),
            _buildLegend(colorScheme),
          ],
        ],
      ),
    );
  }

  Widget _buildLegend(ColorScheme colorScheme) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.1),
            border: Border.all(color: colorScheme.primary),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Available time slots',
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}