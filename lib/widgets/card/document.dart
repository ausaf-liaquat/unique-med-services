import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ums_staff/screens/document/models.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/card/card.dart';

class DocumentCard extends StatelessWidget {
  final Docs doc;
  const DocumentCard({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    final isVerified = doc.verified;
    print("asdasdas: $isVerified");
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: AppCard(
        padding: const EdgeInsets.all(0),
        radius: BorderRadius.circular(20),
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.04),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📂 File icon with modern design
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: HexColor('#9C7BEE').withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: HexColor('#9C7BEE').withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.insert_drive_file_rounded,
                  color: HexColor('#9C7BEE'),
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              // 📑 Document details - Expanded to prevent overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with better spacing
                    Text(
                      doc.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Document type chip with improved layout
                    if (doc.documentType?.name != null &&
                        doc.documentType!.name!.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: HexColor('#9C7BEE').withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.category_outlined,
                                size: 13, color: HexColor('#9C7BEE')),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                doc.documentType!.name!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#7B5DC8'),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 12),

                    // Date information in a compact row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.calendar_today_outlined,
                              size: 12, color: Colors.grey[600]),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            DateFormat('MMM dd, yyyy').format(DateTime.parse(doc.createdAt)),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            _formatRelativeTime(DateTime.parse(doc.createdAt)),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // ✅ Verified Badge with improved layout
              if (isVerified)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: HexColor('#10B981').withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: HexColor('#10B981').withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        color: HexColor('#10B981'),
                        size: 18,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Verified',
                        style: TextStyle(
                          fontSize: 9,
                          color: HexColor('#10B981'),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inHours < 1) return '${difference.inMinutes}m ago';
    if (difference.inDays < 1) return '${difference.inHours}h ago';
    if (difference.inDays == 1) return 'Yesterday';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    if (difference.inDays < 30) return '${difference.inDays ~/ 7}w ago';
    return '${difference.inDays ~/ 30}mo ago';
  }
}