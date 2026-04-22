import 'package:flutter/material.dart';

import '../utils/assets.dart';
import '../utils/colors.dart';
import '../utils/extension.dart';
import 'custom_button_widget.dart';

/// Reject button color (reddish-orange) to match design.
const Color _rejectColor = Color(0xffE85D3A);

/// Shows "Accept Pickup?" confirmation dialog. Same style as success dialog:
/// green circle with checkmark, decorative bubbles, Confirm (green) / Cancel (gray).
void showAcceptPickupDialog(
  BuildContext context, {
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    builder: (ctx) => _AcceptPickupDialog(
      onConfirm: () {
        Navigator.of(ctx).pop();
        onConfirm?.call();
      },
      onCancel: () {
        Navigator.of(ctx).pop();
        onCancel?.call();
      },
    ),
  );
}

/// Shows "Reject Pickup?" confirmation dialog. Same layout as accept dialog:
/// reddish-orange circle with X, optional close button, "Yes Reject" / "Cancel".
void showRejectPickupDialog(
  BuildContext context, {
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    builder: (ctx) => _RejectPickupDialog(
      onConfirm: () {
        Navigator.of(ctx).pop();
        onConfirm?.call();
      },
      onCancel: () {
        Navigator.of(ctx).pop();
        onCancel?.call();
      },
    ),
  );
}

/// Generic "reject-style" dialog using the same UI as [showRejectPickupDialog].
/// Useful for negative confirmations or failures where we want a consistent design.
void showRejectStyleDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String confirmLabel,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    builder: (ctx) => _RejectStyleDialog(
      title: title,
      subtitle: subtitle,
      confirmLabel: confirmLabel,
      onConfirm: () {
        Navigator.of(ctx).pop();
        onConfirm?.call();
      },
      onCancel: () {
        Navigator.of(ctx).pop();
        onCancel?.call();
      },
    ),
  );
}

class _AcceptPickupDialog extends StatelessWidget {
  const _AcceptPickupDialog({
    required this.onConfirm,
    required this.onCancel,
  });

  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  static const Color _green = AppColors.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context) {
                final sw = context.screenWidth;
                final sh = context.screenHeight;
                final scale = (sw + sh) * 0.0004;
                final r = (70 * scale).clamp(50.0, 90.0);
                final decoSize = (13 * scale).clamp(10.0, 18.0);
                return Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(top: -8, right: -r, child: _decoCircle((43 * scale).clamp(35.0, 50.0))),
                    Positioned(top: 55, right: -(r * 0.65), child: _decoCircle(decoSize)),
                    Positioned(top: 85, right: -(r * 0.9), child: _decoCircle(decoSize)),
                    Positioned(top: 120, right: -(r * 0.6), child: _decoCircle(decoSize)),
                    Positioned(top: 25, left: -(r * 0.7), child: _decoCircle(decoSize)),
                    Positioned(top: 100, left: -(r * 0.5), child: _decoCircle(decoSize)),
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(28),
                      decoration: const BoxDecoration(
                        color: _green,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(Assets.checkedIcon),
                    ),
                  ],
                );
              },
            ),
            32.ph,
            Text(
              'Accept Pickup?',
              style: context.robotoFlexSemiBold(fontSize: 22, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            12.ph,
            Text(
              'Are you sure you want to accept this pickup request?',
              style: context.robotoFlexRegular(fontSize: 15, color: AppColors.primaryTextColor),
              textAlign: TextAlign.center,
            ),
            28.ph,
            CustomButtonWidget(
              label: 'Confirm',
              onPressed: onConfirm,
              backgroundColor: _green,
              textColor: Colors.white,
              height: 50,
            ),
            12.ph,
            CustomButtonWidget(
              label: 'Cancel',
              onPressed: onCancel,
              variant: CustomButtonVariant.secondary,
              backgroundColor: const Color(0xff2F2F2F),
              textColor: Colors.white,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _decoCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _green.withValues(alpha: 0.22),
      ),
    );
  }
}

class _RejectPickupDialog extends StatelessWidget {
  const _RejectPickupDialog({
    required this.onConfirm,
    required this.onCancel,
  });

  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Builder(
                  builder: (context) {
                    final sw = context.screenWidth;
                    final sh = context.screenHeight;
                    final scale = (sw + sh) * 0.0004;
                    final r = (70 * scale).clamp(50.0, 90.0);
                    final decoSize = (13 * scale).clamp(10.0, 18.0);
                    return Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -8,
                          right: -r,
                          child: _decoCircle(
                            (43 * scale).clamp(35.0, 50.0),
                            Colors.grey.shade400,
                          ),
                        ),
                        Positioned(
                          top: 55,
                          right: -(r * 0.65),
                          child: _decoCircle(decoSize, Colors.grey.shade400),
                        ),
                        Positioned(
                          top: 85,
                          right: -(r * 0.9),
                          child: _decoCircle(decoSize, Colors.grey.shade400),
                        ),
                        Positioned(
                          top: 120,
                          right: -(r * 0.6),
                          child: _decoCircle(decoSize, Colors.grey.shade400),
                        ),
                        Positioned(
                          top: 25,
                          left: -(r * 0.7),
                          child: _decoCircle(decoSize, Colors.grey.shade400),
                        ),
                        Positioned(
                          top: 100,
                          left: -(r * 0.5),
                          child: _decoCircle(decoSize, Colors.grey.shade400),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: _rejectColor,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            Assets.driverPickupRejectIcon,
                            width: 48,
                            height: 48,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) => const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                
              ],
            ),
            32.ph,
            Text(
              'Reject Pickup?',
              style: context.robotoFlexSemiBold(fontSize: 22, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            12.ph,
            Text(
              'Are you sure you want to reject this pickup request?',
              style: context.robotoFlexRegular(fontSize: 15, color: AppColors.primaryTextColor),
              textAlign: TextAlign.center,
            ),
            28.ph,
            CustomButtonWidget(
              label: 'Yes Reject',
              onPressed: onConfirm,
              variant: CustomButtonVariant.secondary,
              backgroundColor: _rejectColor,
              textColor: Colors.white,
              height: 50,
            ),
            12.ph,
            CustomButtonWidget(
              label: 'Cancel',
              onPressed: onCancel,
              variant: CustomButtonVariant.secondary,
              backgroundColor: const Color(0xff2F2F2F),
              textColor: Colors.white,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _decoCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.3),
      ),
    );
  }
}

class _RejectStyleDialog extends StatelessWidget {
  const _RejectStyleDialog({
    required this.title,
    required this.subtitle,
    required this.confirmLabel,
    required this.onConfirm,
    required this.onCancel,
  });

  final String title;
  final String subtitle;
  final String confirmLabel;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context) {
                final sw = context.screenWidth;
                final sh = context.screenHeight;
                final scale = (sw + sh) * 0.0004;
                final r = (70 * scale).clamp(50.0, 90.0);
                final decoSize = (13 * scale).clamp(10.0, 18.0);
                return Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -8,
                      right: -r,
                      child: _decoCircle(
                        (43 * scale).clamp(35.0, 50.0),
                        Colors.grey.shade400,
                      ),
                    ),
                    Positioned(
                      top: 55,
                      right: -(r * 0.65),
                      child: _decoCircle(decoSize, Colors.grey.shade400),
                    ),
                    Positioned(
                      top: 85,
                      right: -(r * 0.9),
                      child: _decoCircle(decoSize, Colors.grey.shade400),
                    ),
                    Positioned(
                      top: 120,
                      right: -(r * 0.6),
                      child: _decoCircle(decoSize, Colors.grey.shade400),
                    ),
                    Positioned(
                      top: 25,
                      left: -(r * 0.7),
                      child: _decoCircle(decoSize, Colors.grey.shade400),
                    ),
                    Positioned(
                      top: 100,
                      left: -(r * 0.5),
                      child: _decoCircle(decoSize, Colors.grey.shade400),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: _rejectColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        Assets.driverPickupRejectIcon,
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            32.ph,
            Text(
              title,
              style: context.robotoFlexSemiBold(
                fontSize: 22,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            12.ph,
            Text(
              subtitle,
              style: context.robotoFlexRegular(
                fontSize: 15,
                color: AppColors.primaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            28.ph,
            CustomButtonWidget(
              label: confirmLabel,
              onPressed: onConfirm,
              variant: CustomButtonVariant.secondary,
              backgroundColor: _rejectColor,
              textColor: Colors.white,
              height: 50,
            ),
            12.ph,
            CustomButtonWidget(
              label: 'Cancel',
              onPressed: onCancel,
              variant: CustomButtonVariant.secondary,
              backgroundColor: const Color(0xff2F2F2F),
              textColor: Colors.white,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _decoCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.3),
      ),
    );
  }
}
