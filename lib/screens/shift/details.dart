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
        // showActionButton: false,
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
                      onPressed: _loading ? null : () => _handleShiftAction(register.id.toString(), false, context),
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
                      onPressed: _loading ? null : () => _handleShiftAction(register.id.toString(), true, context),
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