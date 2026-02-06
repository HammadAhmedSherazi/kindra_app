import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../export_all.dart';

class HistoryDetailView extends StatelessWidget {
  const HistoryDetailView({super.key, required this.data});

  final HistoryDetailData data;

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: 'History Details',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            24.ph,
            CardWithOverlayWidget(
              child: Column(
                children: [
                  Text(
                    data.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto Flex',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  12.ph,
                  Text(
                    '+${data.pointsAwarded} Points',
                    style: const TextStyle(
                      color: Color(0xff4C9A31),
                      fontSize: 18,
                      fontFamily: 'Roboto Flex',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  24.ph,
                  _DetailRow(
                    label: 'Status',
                    value: _StatusPill(text: data.status),
                  ),
                  16.ph,
                  _DetailRow(
                    label: 'Redemption ID',
                    value: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data.redemptionId,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto Flex',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        8.pw,
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: data.redemptionId),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Redemption ID copied'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Icon(
                            Icons.copy_rounded,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.ph,
                  _DetailRowText(
                    label: 'Type of waste',
                    text: data.typeOfWaste,
                  ),
                  16.ph,
                  _DetailRowText(
                    label: 'Garbage Weight',
                    text: data.garbageWeight,
                  ),
                  16.ph,
                  _DetailRowText(label: 'Date', text: data.date),
                  20.ph,
                  Divider(height: 1, color: Colors.grey.shade300),
                  20.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Points',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${data.totalPoints} Points',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w400,
          ),
        ),
        Flexible(
          child: Align(alignment: Alignment.centerRight, child: value),
        ),
      ],
    );
  }
}

class _DetailRowText extends StatelessWidget {
  const _DetailRowText({required this.label, required this.text});

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF90CAF9), width: 1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF1976D2),
          fontSize: 13,
          fontFamily: 'Roboto Flex',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
