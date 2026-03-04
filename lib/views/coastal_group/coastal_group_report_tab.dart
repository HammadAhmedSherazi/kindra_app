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
    final contentTop = context.screenHeight * 0.22;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CoastalGroupHeader(
            sectionTitle: 'Report Waste',
            height: context.screenHeight * 0.28,
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
                    padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 24),
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
                          onPressed: () {},
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
            height: 140,
            width: double.infinity,
            color: AppColors.primaryColor.withValues(alpha: 0.15),
            child: Center(
              child: Icon(Icons.map_rounded, size: 48, color: AppColors.primaryColor.withValues(alpha: 0.5)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Arcata Bay, CA 95521',
                    hintStyle: context.robotoFlexRegular(fontSize: 14, color: Colors.grey.shade600),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(Assets.locationIcon, width: 22, height: 22),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                12.ph,
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Confirm Location', style: context.robotoFlexSemiBold(fontSize: 14, color: Colors.black87)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _WasteTypeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
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
            style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
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
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primaryColor : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    _wasteTypes[i],
                    style: context.robotoFlexSemiBold(
                      fontSize: 14,
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
    return Container(
      padding: const EdgeInsets.all(16),
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
            'Upload Photo',
            style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
          ),
          12.ph,
          TextField(
            readOnly: true,
            onTap: () {},
            decoration: InputDecoration(
              hintText: 'Upload Photo',
              hintStyle: context.robotoFlexRegular(fontSize: 14, color: Colors.grey.shade600),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(Icons.camera_alt_outlined, size: 22, color: Colors.grey.shade600),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _DescriptionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
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
            'Description',
            style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
          ),
          12.ph,
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Add a short description',
              hintStyle: context.robotoFlexRegular(fontSize: 14, color: Colors.grey.shade600),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
