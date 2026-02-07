import 'dart:async';

import '../../export_all.dart';

/// Masks email for display: abcd***@gmail.com
String maskEmail(String email) {
  if (email.isEmpty) return '';
  final atIndex = email.indexOf('@');
  if (atIndex <= 0) return email;
  final local = email.substring(0, atIndex);
  final domain = email.substring(atIndex);
  if (local.isEmpty) return '***$domain';
  if (local.length <= 4) return '${local[0]}***$domain';
  return '${local.substring(0, 4)}***$domain';
}

class OtpVerificationView extends ConsumerStatefulWidget {
  const OtpVerificationView({super.key, required this.email});

  final String email;

  @override
  ConsumerState<OtpVerificationView> createState() =>
      _OtpVerificationViewState();
}

class _OtpVerificationViewState extends ConsumerState<OtpVerificationView> {
  static const int _otpLength = 5;
  static const int _resendSeconds = 28;

  final List<TextEditingController> _controllers = List.generate(
    _otpLength,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    _otpLength,
    (_) => FocusNode(),
  );

  int _resendCountdown = _resendSeconds;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
    for (final c in _controllers) {
      c.addListener(() => setState(() {}));
    }
  }

  void _startResendTimer() {
    _resendCountdown = _resendSeconds;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        if (_resendCountdown <= 1) {
          _resendCountdown = 0;
          t.cancel();
        } else {
          _resendCountdown--;
        }
      });
    });
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  String get _otpCode => _controllers.map((c) => c.text).join().trim();

  void _onConfirm() {
    if (_otpCode.length != _otpLength) return;
    // TODO: verify OTP with API, then navigate to new password screen
    if (!mounted) return;
    AppRouter.push(CreateNewPasswordView(email: widget.email));
  }

  void _onResend() {
    if (_resendCountdown > 0) return;
    // TODO: call resend OTP API
    _startResendTimer();
  }

  void _onSkip() {
    AppRouter.back();
  }

  void _onOtpChanged(int index, String value) {
    if (value.length == 1) {
      if (index < _otpLength - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final maskedEmail = maskEmail(widget.email);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: BackButtonWidget(onPressed: () => AppRouter.back()),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              50.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.kindraTextLogo,
                    width: 160,
                    height: 67,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              57.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'OTP code verification',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 27.49,
                      fontFamily: 'Roboto Flex',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              12.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'We have sent the OTP code to your email $maskedEmail',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto Flex',
                        fontWeight: FontWeight.w300,
                        height: 1.55,
                      ),
                    ),
                  ),
                ],
              ),
              32.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _otpLength,
                  (index) => Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 0 : 8),
                    child: _OtpDigitField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      onChanged: (v) => _onOtpChanged(index, v),
                      onBackspace: index > 0
                          ? () => _focusNodes[index - 1].requestFocus()
                          : null,
                    ),
                  ),
                ),
              ),
              24.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not receiving email?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: 'Roboto Flex',
                      fontWeight: FontWeight.w300,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
              8.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _onResend,
                    child: Text.rich(
                      TextSpan(
                        text: 'You can resend the Code in ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w300,
                          height: 1.55,
                        ),
                        children: [
                          TextSpan(
                            text: _resendCountdown > 0
                                ? '$_resendCountdown Seconds'
                                : 'Resend',
                            style: TextStyle(
                              color: const Color(0xFF4C9A31),
                              fontSize: 16,
                              fontFamily: 'Roboto Flex',
                              fontWeight: FontWeight.w500,
                              height: 1.55,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              32.ph,
              CustomButtonWidget(
                label: 'Confirm',
                onPressed: _onConfirm,
                enabled: _otpCode.length == _otpLength,
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpDigitField extends StatelessWidget {
  const _OtpDigitField({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.onBackspace,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String) onChanged;
  final VoidCallback? onBackspace;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 51,
      height: 64,
      decoration: const ShapeDecoration(
        color: Color(0xFFEDEDED),
        shape: OvalBorder(
          side: BorderSide(width: 1.50, color: Color(0xFF9F9F9F)),
        ),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Roboto Flex',
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
        onChanged: onChanged,
        onTap: () {
          controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: controller.text.length,
          );
        },
      ),
    );
  }
}
