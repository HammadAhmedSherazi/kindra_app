import 'dart:io';

import '../../export_all.dart';

/// Form: Trash Photo, How Many Liters, Date, Time, Hand over the Trash.
/// Uses existing [EcoPointsSuccessView] on submit.
class UsedOilHandoverFormView extends StatefulWidget {
  const UsedOilHandoverFormView({
    super.key,
    required this.trashImagePath,
  });

  final String trashImagePath;

  @override
  State<UsedOilHandoverFormView> createState() => _UsedOilHandoverFormViewState();
}

class _UsedOilHandoverFormViewState extends State<UsedOilHandoverFormView> {
  final _litersController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _litersController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _updateDateDisplay() {
    if (_selectedDate == null) {
      _dateController.text = '';
    } else {
      final d = _selectedDate!;
      _dateController.text = '${d.day}/${d.month}/${d.year}';
    }
  }

  void _updateTimeDisplay() {
    if (_selectedTime == null) {
      _timeController.text = '';
    } else {
      final t = _selectedTime!;
      final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
      final am = t.period == DayPeriod.am ? 'AM' : 'PM';
      _timeController.text = '${h.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')} $am';
    }
  }

  Future<void> _openCalendar() async {
    final picked = await showCalendarPickerDialog(
      context,
      initialDate: _selectedDate ?? DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _updateDateDisplay();
      });
    }
  }

  Future<void> _openTimePicker() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _updateTimeDisplay();
      });
    }
  }

  void _submit() {
    final liters = _litersController.text.trim();
    if (liters.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter quantity (liters)'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select date'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select time'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    final data = HistoryDetailData(
      title: 'Eco-Points Credited Successfully',
      pointsAwarded: 200,
      status: 'Success',
      redemptionId: '0 123 456 ****',
      typeOfWaste: 'Non-organic waste',
      garbageWeight: '${liters} liter',
      date: _formatDate(_selectedDate!),
      totalPoints: 200,
    );
    AppRouter.back();
    AppRouter.push(EcoPointsSuccessView(data: data));
  }

  String _formatDate(DateTime d) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final dayName = days[d.weekday - 1];
    return '$dayName, ${d.day} ${_monthName(d.month)}, ${d.year}';
  }

  String _monthName(int m) {
    const names = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return names[m - 1];
  }

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: 'Used Oil Handover (Verified)',
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              16.ph,
              Text(
                'Trash Photo',
                style: context.robotoFlexRegular(fontSize: 18, color: Colors.black),
              ),
              8.ph,
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(widget.trashImagePath),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              20.ph,
              CustomTextFieldWidget(
                controller: _litersController,
                label: 'How Many Liters?',
                hint: 'Enter quantity (liters)',
                keyboardType: TextInputType.number,
                prefixIconConstraints: BoxConstraints(minWidth: 28, minHeight: 28),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  child: Image.asset(Assets.literIcon, width: 28, height: 28, color: Colors.grey.shade600),
                ),
              ),
              16.ph,
              CustomTextFieldWidget(
                controller: _dateController,
                label: 'Date',
                hint: 'Enter Date',
                readOnly: true,
                onTap: _openCalendar,
                prefixIconConstraints: BoxConstraints(minWidth: 28, minHeight: 28),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  child: Image.asset(Assets.dateIcon, width: 28, height: 28, color: Colors.grey.shade600),
                ),
              ),
              16.ph,
              CustomTextFieldWidget(
                controller: _timeController,
                label: 'Time',
                hint: 'Enter Time',
                readOnly: true,
                onTap: _openTimePicker,
                prefixIconConstraints: BoxConstraints(minWidth: 28, minHeight: 28),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  child: Image.asset(Assets.timeIcon, width: 28, height: 28, color: Colors.grey.shade600),
                ),
              ),
              32.ph,
              CustomButtonWidget(
                label: 'Hand over the Trash',
                onPressed: _submit,
                textSize: 18,
              ),
              // 24.ph,
            ],
          ),
        ),
      ),
    );
  }
}
