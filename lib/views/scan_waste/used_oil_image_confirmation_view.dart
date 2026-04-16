import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../export_all.dart';

/// Shows captured trash photo with Retake / Next. On Next, opens handover form.
class UsedOilImageConfirmationView extends StatefulWidget {
  const UsedOilImageConfirmationView({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<UsedOilImageConfirmationView> createState() =>
      _UsedOilImageConfirmationViewState();
}

class _UsedOilImageConfirmationViewState
    extends State<UsedOilImageConfirmationView> {
  bool _isLoading = false;

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
                    File(widget.imagePath),
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
                  vertical: 20,
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
              Row(
                spacing: 40,
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                      label: 'Retake',
                      variant: CustomButtonVariant.outlined,
                      onPressed: _isLoading ? null : _retake,
                      borderColor:
                          const Color(0xFF020202).withValues(alpha: 0.70),
                      textColor:
                          const Color(0xFF020202).withValues(alpha: 0.70),
                    ),
                  ),
                  Expanded(
                    child: CustomButtonWidget(
                      label: _isLoading ? 'Verifying...' : 'Next',
                      onPressed: _isLoading ? null : _onNext,
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

  Future<void> _retake() async {
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (photo == null || !AppRouter.navKey.currentContext!.mounted) return;
    AppRouter.back();
    await AppRouter.push(UsedOilImageConfirmationView(imagePath: photo.path));
  }

  Future<void> _onNext() async {
    setState(() => _isLoading = true);
    try {
      final key = dotenv.env['GEMINI_API_KEY'];
      if (key == null || key.trim().isEmpty) {
        throw Exception('GEMINI_API_KEY is missing');
      }

      final modelId = dotenv.env['GEMINI_MODEL']?.trim();
      final service = modelId != null && modelId.isNotEmpty
          ? GeminiOilDetectionService(apiKey: key.trim(), model: modelId)
          : GeminiOilDetectionService(apiKey: key.trim());
      final result =
          await service.detectOilFromFile(File(widget.imagePath));

      if (!mounted) return;
      await AppRouter.push(
        UsedOilVerificationResultView(
          imagePath: widget.imagePath,
          geminiResult: result,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification failed: $e')),
      );
      await AppRouter.push(
        UsedOilVerificationResultView(imagePath: widget.imagePath),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
