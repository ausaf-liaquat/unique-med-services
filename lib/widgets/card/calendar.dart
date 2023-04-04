import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../shared/theme/color.dart';

class CalendarCard extends StatefulWidget {
  const CalendarCard({super.key});

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  // ignore: unused_field
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.02),
          blurRadius: 6,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ], borderRadius: BorderRadius.circular(20), color: HexColor('#F1FAFD')),
      child: TableCalendar(
          rowHeight: 43,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          daysOfWeekHeight: 43,
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: AppColorScheme().black100),
              weekendStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: AppColorScheme().black100)),
          calendarStyle: CalendarStyle(
            tablePadding: const EdgeInsets.symmetric(horizontal: 12),
            selectedDecoration: BoxDecoration(
              color: HexColor('#2AABE4'),
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: HexColor('#2AABE4'))),
            todayTextStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: HexColor('#2AABE4'),
              letterSpacing: 0.4,
            ),
            defaultTextStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: AppColorScheme().black90,
              letterSpacing: 0.4,
            ),
          ),
          headerStyle: HeaderStyle(
            headerPadding: const EdgeInsets.fromLTRB(6, 8, 8, 8),
            titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
              color: AppColorScheme().black100,
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: AppColorScheme().black100,
              size: 24,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: AppColorScheme().black100,
              size: 24,
            ),
            formatButtonVisible: false,
            formatButtonShowsNext: true,
          ),
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          }),
    );
  }
}
