import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../export_all.dart';

/// Shown after user confirms the used oil image. Displays verification result,
/// details with gram-unit prices, and either "Hand over the used oil" or "Retake"
/// when no oil was detected.
class UsedOilVerificationResultView extends StatelessWidget {
  const UsedOilVerificationResultView({
    super.key,
    required this.imagePath,
    this.geminiResult,
  });

  final String imagePath;
  final GeminiOilDetectionResult? geminiResult;

  /// Demo details; replace with API response when backend is ready.
  static const List<({String name, String price})> _demoDetails = [
    (name: 'Plastic Bottle Caps', price: '\$0.0085'),
    (name: 'Plastic Bottle', price: '\$0.085'),
  ];

  @override
  Widget build(BuildContext context) {
    final oilDetected = geminiResult?.oilDetected;
    final confidence = geminiResult?.confidence;
    final reason = geminiResult?.reason;

    final statusTitle = oilDetected == null
        ? 'Verification Pending'
        : (oilDetected ? 'Oil Detected.' : 'No Oil Detected.');
    final statusColor = oilDetected == null
        ? const Color(0xFFF0FBFF)
        : (oilDetected ? const Color(0xFFF0FBFF) : const Color(0xFFFFF7F0));
    final statusBorder = oilDetected == null
        ? const Color(0xFF4EC5EB)
        : (oilDetected ? const Color(0xFF4EC5EB) : const Color(0xFFEBA44E));

    return CustomInnerScreenTemplate(
      title: 'Oil Type Verification Result',
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              16.ph,
              // Used Oil Photo
              Text(
                'Used Oil Photo',
                style: context.robotoFlexRegular(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              12.ph,
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.file(
                    File(imagePath),
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              24.ph,
              // Oil Detected card
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusBorder),
                ),
                child: Column(
                  children: [
                    Text(
                      statusTitle,
                      style: context.robotoFlexSemiBold(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    8.ph,
                    Text(
                      oilDetected == null
                          ? 'We are verifying your image...'
                          : 'The Price listed is the price in gram units.',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexRegular(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    if (confidence != null && oilDetected != true) ...[
                      10.ph,
                      Text(
                        'Confidence: $confidence%',
                        style: context.robotoFlexRegular(
                          fontSize: 13,
                          color: Colors.black.withValues(alpha: 0.70),
                        ),
                      ),
                    ],
                    if (reason != null && reason.trim().isNotEmpty) ...[
                      6.ph,
                      Text(
                        reason,
                        textAlign: TextAlign.center,
                        style: context.robotoFlexRegular(
                          fontSize: 13,
                          color: Colors.black.withValues(alpha: 0.60),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              24.ph,
              // Details
              Text(
                'Details',
                style: context.robotoFlexRegular(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              12.ph,
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFECEFF4),
                  borderRadius: BorderRadius.circular(12),
                  
                ),
                child: Column(
                  spacing: 12,
                  children: [
                    ..._demoDetails.map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.name,
                            style: context.robotoFlexRegular(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            e.price,
                            style: context.robotoFlexRegular(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              30.ph,
              if (oilDetected == false)
                CustomButtonWidget(
                  label: 'Retake',
                  variant: CustomButtonVariant.outlined,
                  onPressed: () => _onRetake(),
                  borderColor:
                      const Color(0xFF020202).withValues(alpha: 0.70),
                  textColor:
                      const Color(0xFF020202).withValues(alpha: 0.70),
                  textSize: 18,
                )
              else
                CustomButtonWidget(
                  label: 'Hand over the used oil',
                  onPressed: _onHandOver,
                  textSize: 18,
                ),
              24.ph,
            ],
          ),
        ),
      ),
    );
  }

  void _onHandOver() {
    AppRouter.push(UsedOilHandoverFormView(trashImagePath: imagePath));
  }

  Future<void> _onRetake() async {
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (photo == null || !AppRouter.navKey.currentContext!.mounted) return;
    AppRouter.back();
    AppRouter.back();
    await AppRouter.push(
      UsedOilImageConfirmationView(imagePath: photo.path),
    );
  }
}
