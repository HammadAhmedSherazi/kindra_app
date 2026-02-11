import 'package:table_calendar/table_calendar.dart';

import '../../export_all.dart';

/// Indonesian month names and weekday abbreviations to match design reference.
const List<String> _idMonths = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
];
const List<String> _idWeekdays = ['SEN', 'SEL', 'RAB', 'KAM', 'JUM', 'SAB', 'MIN'];

class PickupScheduleView extends ConsumerStatefulWidget {
  const PickupScheduleView({super.key});

  @override
  ConsumerState<PickupScheduleView> createState() => _PickupScheduleViewState();
}

class _PickupScheduleViewState extends ConsumerState<PickupScheduleView> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 31);
  bool _isAm = true;

  static const double _headerHeight = 420;
  static const double _contentTop = 230;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _isAm = picked.hour < 12;
      });
    }
  }

  String _formatTime() {
    final h = _selectedTime.hourOfPeriod == 0 ? 12 : _selectedTime.hourOfPeriod;
    final m = _selectedTime.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              sectionTitle: 'Pickup Schedule',
              height: _headerHeight,
              showZoneLabel: false,
              logoutTextColor: AppColors.primaryColor,
              onLogout: () {},
            ),
            Positioned(
              top: _contentTop,
              left: horizontalPadding,
              right: horizontalPadding,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildCalendarCard(context),
                    20.ph,
                    _buildTimeRow(context),
                    32.ph,
                    CustomButtonWidget(
                      label: 'Confirm Pickup',
                      onPressed: () {
                        AppRouter.push(
                          PickupScheduledSuccessView(
                            date: _selectedDay,
                            timeRange:
                                '${_formatTime()} ${_isAm ? "AM" : "PM"} - 12:00 PM',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) =>
            _selectedDay.year == day.year &&
            _selectedDay.month == day.month &&
            _selectedDay.day == day.day,
        onDaySelected: (selected, focused) {
          setState(() {
            _selectedDay = selected;
            _focusedDay = focused;
          });
        },
        onPageChanged: (focused) => setState(() => _focusedDay = focused),
        calendarStyle: CalendarStyle(
          selectedDecoration: const BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w500,
          ),
          todayDecoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          defaultTextStyle: context.robotoFlexRegular(
            fontSize: 16,
            color: Colors.black,
          ),
          weekendTextStyle: context.robotoFlexRegular(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: context.robotoFlexSemiBold(
            fontSize: 16,
            color: Colors.black,
          ),
          titleTextFormatter: (date, _) =>
              '${_idMonths[date.month - 1]} ${date.year}',
          leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.black),
          rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.black),
        ),
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            final index = day.weekday - 1;
            return Center(
              child: Text(
                _idWeekdays[index],
                style: context.robotoFlexRegular(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTimeRow(BuildContext context) {
    return Row(
      children: [
        Text(
          'Time',
          style: context.robotoFlexSemiBold(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        16.pw,
        GestureDetector(
          onTap: _selectTime,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              _formatTime(),
              style: context.robotoFlexRegular(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        12.pw,
        _timePeriodChip('AM', _isAm),
        8.pw,
        _timePeriodChip('PM', !_isAm),
      ],
    );
  }

  Widget _timePeriodChip(String label, bool selected) {
    return GestureDetector(
      onTap: () => setState(() => _isAm = label == 'AM'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.grey.shade200 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? Colors.grey.shade400 : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
