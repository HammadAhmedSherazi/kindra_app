import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../export_all.dart';

/// Shows captured trash photo with Retake / Next. On Next, opens handover form.
class UsedOilImageConfirmationView extends StatelessWidget {
  const UsedOilImageConfirmationView({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: 'Used Oil Handover (Verified)',
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              16.ph,
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(imagePath),
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              24.ph,
              Text(
                'Image Confirmation',
                textAlign: TextAlign.center,
                style: context.robotoFlexSemiBold(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20
                ),
                child: Text(
                  'Deposit your and collect points easily! Every time you drop off your trash',
                  textAlign: TextAlign.center,
                  style: context.robotoFlexRegular(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ),
              // const Spacer(),
              Row(
                spacing: 40,
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                      label: 'Retake',
                      variant: CustomButtonVariant.outlined,
                      onPressed: _retake,
                      borderColor: const Color(0xFF020202).withValues(alpha: 0.70),
                      textColor: const Color(0xFF020202).withValues(alpha: 0.70),
                    ),
                  ),
                
                  Expanded(
                    child: CustomButtonWidget(
                      label: 'Next',
                      onPressed: _onNext,
                    ),
                  ),
                ],
              ),
              24.ph,
            ],
          ),
        ),
      ),
    );
  }

  void _retake() async {
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (photo == null || !AppRouter.navKey.currentContext!.mounted) return;
    AppRouter.back();
    await AppRouter.push(UsedOilImageConfirmationView(imagePath: photo.path));
  }

  void _onNext() {
    AppRouter.push(UsedOilVerificationResultView(imagePath: imagePath));
  }
}
