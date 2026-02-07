import 'package:table_calendar/table_calendar.dart';

import '../../export_all.dart';

/// Full-screen calendar to pick a date. Pops with selected [DateTime].
class CalendarPickerView extends StatelessWidget {
  const CalendarPickerView({
    super.key,
    this.initialDate,
  });

  final DateTime? initialDate;

  @override
  Widget build(BuildContext context) {
    return _CalendarPickerBody(initialDate: initialDate ?? DateTime.now());
  }
}

class _CalendarPickerBody extends StatefulWidget {
  const _CalendarPickerBody({required this.initialDate});

  final DateTime initialDate;

  @override
  State<_CalendarPickerBody> createState() => _CalendarPickerBodyState();
}

class _CalendarPickerBodyState extends State<_CalendarPickerBody> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialDate;
    _selectedDay = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: 'Select Date',
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              8.ph,
              TableCalendar(
                firstDay: DateTime(2020, 1, 1),
                lastDay: DateTime(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = selected;
                    _focusedDay = focused;
                  });
                },
                onPageChanged: (focused) {
                  _focusedDay = focused;
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: context.robotoFlexSemiBold(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: AppColors.primaryColor,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              24.ph,
              CustomButtonWidget(
                label: 'Confirm Date',
                onPressed: () {
                  Navigator.of(context).pop(_selectedDay);
                },
              ),
              24.ph,
            ],
          ),
        ),
      ),
    );
  }
}
