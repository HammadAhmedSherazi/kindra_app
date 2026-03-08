import '../../export_all.dart';

class CoastalGroupReportTab extends ConsumerStatefulWidget {
  const CoastalGroupReportTab({super.key});

  @override
  ConsumerState<CoastalGroupReportTab> createState() =>
      _CoastalGroupReportTabState();
}

class _CoastalGroupReportTabState extends ConsumerState<CoastalGroupReportTab> {
  int _selectedWasteTypeIndex = 0;
  static const _wasteTypes = ['Oil Spill', 'Plastic', 'Fishing Net', 'Other'];

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.24;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CoastalGroupHeader(
            sectionTitle: 'Report Waste',
            height: context.screenHeight * 0.30,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
          ),
          Positioned(
            top: contentTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: _LocationCard(),
                ),
                16.ph,
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      0,
                      horizontalPadding,
                      24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _WasteTypeCard(),
                        20.ph,
                        _UploadPhotoCard(),
                        20.ph,
                        _DescriptionCard(),
                        24.ph,
                        CustomButtonWidget(
                          label: 'Submit Report',
                          onPressed: () => _showReportSubmittedDialog(context),
                          height: 52,
                        ),
                        100.ph,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _LocationCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170,
            margin: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.map_rounded,
                size: 48,
                color: AppColors.primaryColor.withValues(alpha: 0.5),
              ),
            ),
          ),
          Column(
            children: [
              CustomTextFieldWidget(
                hint: 'Arcata Bay, CA 95521',
                padding: EdgeInsets.symmetric(vertical: 10),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  child: Image.asset(
                    Assets.locationIcon,
                    width: 22,
                    height: 22,
                    color: Colors.black.withValues(alpha: 0.3),
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 22,
                  minHeight: 22,
                ),
              ),
              12.ph,
              CustomButtonWidget(
                label: 'Confirm Location',
                onPressed: () => _showLocationConfirmedDialog(context),
                backgroundColor: Color(0xff414141),
                height: 48,
                expandWidth: true,
              ),
              15.ph,
            ],
          ),
        ],
      ),
    );
  }

  Widget _WasteTypeCard() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Waste Type',
            style: context.robotoFlexBold(fontSize: 22, color: Colors.black),
          ),
          12.ph,
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(_wasteTypes.length, (i) {
              final selected = i == _selectedWasteTypeIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedWasteTypeIndex = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primaryColor
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    _wasteTypes[i],
                    style: context.robotoFlexSemiBold(
                      fontSize: 12,
                      color: selected ? Colors.white : Colors.grey.shade700,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _UploadPhotoCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Photo',
          style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
        ),
        12.ph,
        CustomTextFieldWidget(
          hint: 'Upload Photo',
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 10,
            ),
            child: Icon(
              Icons.camera_alt,
              size: 22,
              color: Colors.grey.shade600,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 22,
            minHeight: 22,
          ),
          readOnly: true,
          onTap: () {},
        )
      ],
    );
  }

  Widget _DescriptionCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
        ),
        12.ph,
        CustomTextFieldWidget(
          hint: 'Add a short description',
          maxLines: 6,
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
        ),
      ],
    );
  }

  void _showLocationConfirmedDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.06,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Location Confirmed',
                style: context.robotoFlexBold(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              12.ph,
              Row(
                children: [
                  Image.asset(
                    Assets.locationIcon,
                    width: 20,
                    height: 20,
                    color: Colors.black87,
                  ),
                  8.pw,
                  Expanded(
                    child: Text(
                      'Arcata Bay, CA 95521',
                      style: context.robotoFlexMedium(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              4.ph,
              Padding(
                padding: EdgeInsets.only(left: 28),
                child: Text(
                  'Location recorded: Arcata Bay, CA',
                  style: context.robotoFlexRegular(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              16.ph,
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.map_rounded,
                      size: 48,
                      color: AppColors.primaryColor.withValues(alpha: 0.5),
                    ),
                    Positioned(
                      bottom: 24,
                      child: Icon(
                        Icons.location_on,
                        size: 40,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              20.ph,
              CustomButtonWidget(
                label: 'Continue',
                onPressed: () => Navigator.of(ctx).pop(),
                height: 50,
              ),
              12.ph,
              CustomButtonWidget(
                label: 'Back',
                onPressed: () => Navigator.of(ctx).pop(),
                backgroundColor: const Color(0xff414141),
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReportSubmittedDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.06,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Report Submitted!',
                  style: context.robotoFlexBold(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
              16.ph,
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  Assets.oceanGuardiansImage,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              16.ph,
              Center(
                child: Text(
                  'Your report has been submitted successfully',
                  style: context.robotoFlexMedium(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              4.ph,
              Center(
                child: Text(
                  'Thank you for helping protect our coastline!',
                  style: context.robotoFlexRegular(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              20.ph,
              CustomButtonWidget(
                label: 'Done',
                onPressed: () => Navigator.of(ctx).pop(),
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
