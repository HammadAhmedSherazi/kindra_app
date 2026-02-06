import 'dart:io';

import '../../export_all.dart';

/// Shown after user confirms the used oil image. Displays verification result
/// (Oil Detected), details with gram-unit prices, and "Hand over the used oil" CTA.
class UsedOilVerificationResultView extends StatelessWidget {
  const UsedOilVerificationResultView({super.key, required this.imagePath});

  final String imagePath;

  /// Demo details; replace with API response when backend is ready.
  static const List<({String name, String price})> _demoDetails = [
    (name: 'Plastic Bottle Caps', price: '\$0.0085'),
    (name: 'Plastic Bottle', price: '\$0.085'),
  ];

  @override
  Widget build(BuildContext context) {
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
                  color: const Color(0xFFF0FBFF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF4EC5EB)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Oil Detected.',
                      style: context.robotoFlexSemiBold(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    8.ph,
                    Text(
                      'The Price listed is the price in gram units.',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexRegular(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
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
}
