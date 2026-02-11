import 'package:table_calendar/table_calendar.dart';

import '../../export_all.dart';

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
    return Scaffold(
      body: Column(
        children: [
          _buildCommunityHeader(context, 'Pickup Schedule'),
          Expanded(
            child: Container(
              color: const Color(0xFFF5F5F5),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
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
                        onPageChanged: (focused) =>
                            setState(() => _focusedDay = focused),
                        calendarStyle: CalendarStyle(
                          selectedDecoration: const BoxDecoration(
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
                          titleCentered: true,
                          titleTextStyle: context.robotoFlexSemiBold(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          leftChevronIcon: const Icon(Icons.chevron_left),
                          rightChevronIcon: const Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    20.ph,
                    Row(
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${_formatTime()} ${_isAm ? "AM" : "PM"}',
                              style: context.robotoFlexRegular(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        12.pw,
                        Row(
                          children: [
                            _timePeriodChip('AM', _isAm),
                            8.pw,
                            _timePeriodChip('PM', !_isAm),
                          ],
                        ),
                      ],
                    ),
                    32.ph,
                    CustomButtonWidget(
                      label: 'Confirm Pickup',
                      onPressed: () {
                        AppRouter.push(
                          PickupScheduledSuccessView(
                            date: _selectedDay,
                            timeRange: '${_formatTime()} ${_isAm ? "AM" : "PM"} - 12:00 PM',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timePeriodChip(String label, bool selected) {
    return GestureDetector(
      onTap: () => setState(() => _isAm = label == 'AM'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.grey.shade600 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontSize: 14,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCommunityHeader(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 8,
        left: 20,
        right: 20,
        bottom: 16,
      ),
      decoration: const BoxDecoration(color: AppColors.primaryColor),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => AppRouter.back(),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
              ),
            ),
            16.pw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Community Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Roboto Flex',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Roboto Flex',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
