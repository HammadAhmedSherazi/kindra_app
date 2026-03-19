import '../../../export_all.dart';

import 'driver_pickup_flow_shared_widgets.dart';

enum _ReportIssueOption { tooFar, busy, vehicleIssue, other }

class DriverReportIssueView extends StatefulWidget {
  const DriverReportIssueView({super.key});

  @override
  State<DriverReportIssueView> createState() => _DriverReportIssueViewState();
}

class _DriverReportIssueViewState extends State<DriverReportIssueView> {


  _ReportIssueOption _selected = _ReportIssueOption.tooFar;
  final TextEditingController _otherController = TextEditingController();

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_selected == _ReportIssueOption.other &&
        _otherController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe your issue.')),
      );
      return;
    }
    AppRouter.push(const DriverReportIssueSuccessView());
  }

  void _onCancel() {
    AppRouter.push(const DriverReportIssueCanceledView());
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: const DriverFlowBottomNavBar(currentIndex: 1),
      body: Stack(
        children: [
          CommunityDashboardHeader(
            subtitle: 'Driver',
            sectionTitle: 'Report Issue',
            showZoneLabel: false,
            onLogout: () {},
            showNotificationIcon: true,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
            height: 280,
           
         
           
            headerCaption: 'What is the reason for this issue?',
           
          ),
          Positioned(
            top: 330,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                8,
                horizontalPadding,
                120,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                 
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _IssueRadioTile(
                          label: 'Too Far',
                          selected: _selected == _ReportIssueOption.tooFar,
                          onTap: () => setState(() => _selected = _ReportIssueOption.tooFar),
                        ),
                        _IssueRadioTile(
                          label: 'Busy',
                          selected: _selected == _ReportIssueOption.busy,
                          onTap: () => setState(() => _selected = _ReportIssueOption.busy),
                        ),
                        _IssueRadioTile(
                          label: 'Vehicle issue',
                          selected: _selected == _ReportIssueOption.vehicleIssue,
                          onTap: () => setState(() => _selected = _ReportIssueOption.vehicleIssue),
                        ),
                        _IssueRadioTile(
                          label: 'Other (please specify)',
                          selected: _selected == _ReportIssueOption.other,
                          onTap: () => setState(() => _selected = _ReportIssueOption.other),
                        ),
                        if (_selected == _ReportIssueOption.other) ...[
                          12.ph,
                          TextField(
                            controller: _otherController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: 'Describe the issue…',
                              hintStyle: context.robotoFlexRegular(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                              contentPadding: const EdgeInsets.all(14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            style: context.robotoFlexRegular(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  24.ph,
                  CustomButtonWidget(
                    label: 'Submit',
                    onPressed: _onSubmit,
                    height: 54,
                    backgroundColor: const Color(0xFFE53935),
                    textColor: Colors.white,
                  ),
                  12.ph,
                  CustomButtonWidget(
                    label: 'Cancel',
                    onPressed: _onCancel,
                    height: 54,
                    backgroundColor: const Color(0xff2F2F2F),
                    textColor: Colors.white,
                    variant: CustomButtonVariant.secondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IssueRadioTile extends StatelessWidget {
  const _IssueRadioTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.primaryColor : Colors.grey.shade400,
                  width: selected ? 2 : 1.5,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            14.pw,
            Expanded(
              child: Text(
                label,
                style: context.robotoFlexRegular(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
