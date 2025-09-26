import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ums_staff/core/http.dart';
import 'package:ums_staff/screens/landing.dart';
import 'package:ums_staff/screens/shift/models.dart';
import 'package:ums_staff/widgets/messages/snack_bar.dart';
import '../../shared/theme/color.dart';
import '../../widgets/others/back_layout.dart';

class ShiftDetailScreen extends StatefulWidget {
  const ShiftDetailScreen({super.key});

  static const route = '/shift/123';

  @override
  State<ShiftDetailScreen> createState() => _ShiftDetailScreenState();
}

class _ShiftDetailScreenState extends State<ShiftDetailScreen> {
  bool _loading = false;
  bool _accepting = false;
  bool _declining = false;

  void _showAcceptConfirmation(ShiftModel register) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return _buildConfirmationDialog(
          isAccept: true,
          register: register,
          title: 'Accept Shift',
          subtitle: 'You are about to accept this shift offer',
          icon: Icons.thumb_up_rounded,
          iconColor: Colors.green.shade600,
          primaryButtonText: 'Accept Shift',
          warningMessage: 'Once accepted, this shift will be added to your schedule.',
        );
      },
    );
  }

  void _showDeclineConfirmation(ShiftModel register) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return _buildConfirmationDialog(
          isAccept: false,
          register: register,
          title: 'Decline Shift',
          subtitle: 'You are about to decline this shift offer',
          icon: Icons.thumb_down_rounded,
          iconColor: Colors.red.shade600,
          primaryButtonText: 'Decline Shift',
          warningMessage: 'This action cannot be undone. The shift will be offered to other clinicians.',
        );
      },
    );
  }

  Widget _buildConfirmationDialog({
    required bool isAccept,
    required ShiftModel register,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required String primaryButtonText,
    required String warningMessage,
  }) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 32,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isAccept
                      ? [
                    Colors.green.withOpacity(0.1),
                    Colors.green.withOpacity(0.05),
                  ]
                      : [
                    Colors.red.withOpacity(0.1),
                    Colors.red.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColorScheme().black90,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColorScheme().black60,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildConfirmationDetailItem(
                    icon: Icons.work_rounded,
                    title: 'Shift Title',
                    value: register.title ?? 'Not specified',
                    color: Colors.blue.shade600,
                  ),
                  SizedBox(height: 12),
                  _buildConfirmationDetailItem(
                    icon: Icons.calendar_today_rounded,
                    title: 'Date',
                    value: register.date ?? 'Not specified',
                    color: Colors.purple.shade600,
                  ),
                  SizedBox(height: 12),
                  _buildConfirmationDetailItem(
                    icon: Icons.access_time_rounded,
                    title: 'Timing',
                    value: register.shiftHour ?? 'Not specified',
                    color: Colors.orange.shade600,
                  ),
                  SizedBox(height: 12),
                  _buildConfirmationDetailItem(
                    icon: Icons.attach_money_rounded,
                    title: 'Rate',
                    value: '\$${register.ratePerHour}/hour' ?? 'Not specified',
                    color: Colors.green.shade600,
                  ),
                  SizedBox(height: 24),

                  // Warning Message
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isAccept ? Colors.blue.shade50 : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isAccept ? Colors.blue.shade200 : Colors.orange.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: isAccept ? Colors.blue.shade700 : Colors.orange.shade700,
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            warningMessage,
                            style: TextStyle(
                              fontSize: 12,
                              color: isAccept ? Colors.blue.shade800 : Colors.orange.shade800,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Button Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColorScheme().black20)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColorScheme().black60,
                        side: BorderSide(color: AppColorScheme().black40),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _handleShiftAction(register.id.toString(), isAccept, context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isAccept ? Colors.green.shade600 : Colors.red.shade600,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: _loading
                          ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : Text(
                        primaryButtonText,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationDetailItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColorScheme().black60,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColorScheme().black90,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _handleShiftAction(String id, bool accept, BuildContext context) async {
    if (!mounted) return;

    setState(() {
      if (accept) {
        _accepting = true;
      } else {
        _declining = true;
      }
      _loading = true;
    });

    try {
      final http = HttpRequest();
      final response = accept ? await http.shiftsAccept(id) : await http.shiftsDecline(id);

      if (!mounted) return;

      setState(() {
        _loading = false;
        _accepting = false;
        _declining = false;
      });

      if (!response.success) {
        SnackBarMessage.errorSnackbar(context, response.message);
        return;
      }

      // Show success message
      if (accept) {
        SnackBarMessage.successSnackbar(context, '🎉 Shift accepted successfully!');
      } else {
        SnackBarMessage.waringSnackbar(context, 'Shift declined');
      }

      // Navigate back to shifts list
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => LandingScreen(selectedIndex: 1),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _accepting = false;
        _declining = false;
      });

      SnackBarMessage.errorSnackbar(context, 'An error occurred. Please try again.');
    }
  }

  Widget _buildInfoCard(String title, String value, IconData icon, {Color? iconColor}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor?.withOpacity(0.1) ?? Theme.of(context).colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: iconColor ?? Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isNotEmpty ? value : 'Not specified',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    final register = arguments['shiftModel'] as ShiftModel? ?? ShiftModel(
      id: 1,
      title: '',
      createdAt: '',
      additionalComments: '',
      clinicianType: '',
      date: '',
      ratePerHour: '',
      shiftHour: '',
      shiftLocation: '',
      shiftNote: '',
      totalAmount: '',
      updatedAt: '',
      userId: '',
    );

    List<String> shiftNote = [];
    if (register.shiftNote != null && register.shiftNote!.isNotEmpty) {
      try {
        shiftNote = (jsonDecode(register.shiftNote.toString()) as List<dynamic>)
            .map((e) => e.toString())
            .toList();
      } catch (e) {
        shiftNote = [register.shiftNote!];
      }
    }

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: BackLayout(
        text: 'Shift Details',
        page: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primary.withOpacity(0.05),
                      colorScheme.primary.withOpacity(0.02),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            register.title ?? 'Shift Offer',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onBackground,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (register.date.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              register.date,
                              style: TextStyle(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    if (shiftNote.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: shiftNote.map((note) => _buildTagChip(
                          note,
                          _getTagColor(note, colorScheme),
                        )).toList(),
                      ),
                  ],
                ),
              ),

              // Shift Details Cards
              _buildInfoCard('Clinician Type', register.clinicianType, Icons.medical_services),
              _buildInfoCard('Rate Per Hour', '\$${register.ratePerHour}', Icons.attach_money,
                  iconColor: Colors.green),
              _buildInfoCard('Shift Timing', register.shiftHour, Icons.access_time,
                  iconColor: Colors.orange),
              _buildInfoCard('Total Amount', '\$${register.totalAmount}', Icons.payments,
                  iconColor: Colors.purple),
              _buildInfoCard('Location', register.shiftLocation, Icons.location_on,
                  iconColor: Colors.red),

              // Additional Comments
              if (register.additionalComments?.isNotEmpty == true)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 24, top: 8),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.note, size: 20, color: colorScheme.primary),
                          const SizedBox(width: 12),
                          Text(
                            'Additional Comments',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        register.additionalComments!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.8),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

              // Action Buttons
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: _loading ? null : () => _showDeclineConfirmation(register),
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.errorContainer,
                        foregroundColor: colorScheme.onErrorContainer,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: _declining
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.thumb_down, size: 20),
                          const SizedBox(width: 8),
                          Text('Decline', style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: _loading ? null : () => _showAcceptConfirmation(register),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: _accepting
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.thumb_up, size: 20),
                          const SizedBox(width: 8),
                          Text('Accept', style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTagColor(String tag, ColorScheme colorScheme) {
    final tagColors = {
      'PM': Colors.orange,
      'LATE CALL': Colors.red,
      'URGENT': Colors.redAccent,
      'NEW': Colors.green,
      'SPECIAL': Colors.purple,
    };
    return tagColors[tag.toUpperCase()] ?? colorScheme.primary;
  }
}