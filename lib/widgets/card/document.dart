import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';
import 'package:ums_staff/screens/document/models.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/card/card.dart';
import 'package:ums_staff/widgets/dataDisplay/row_item.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

class DocumentCard extends StatelessWidget {
  late Docs doc;
  DocumentCard({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: AppCard(
        padding: const EdgeInsets.all(0),
        radius: BorderRadius.circular(16),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.08),
        child: Row(
          children: [
            // Document thumbnail with modern design
            Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                color: HexColor('#58BDEA').withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    color: Colors.grey[100],
                    child: const SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 80,
                        height: 100,
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  fit: BoxFit.cover,
                  imageUrl: doc.documentUrl,
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.description_outlined,
                          color: Colors.grey[400],
                          size: 32,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Document',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Document details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Document title
                    Text(
                      doc.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Document type
                    if (doc.documentType?.name != null && doc.documentType!.name!.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: HexColor('#58BDEA').withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.category_outlined,
                              color: HexColor('#58BDEA'),
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              doc.documentType!.name!,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: HexColor('#58BDEA'),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 8),

                    // Upload date
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.grey[500],
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Uploaded: ${DateFormat('MMM dd, yyyy').format(DateTime.parse(doc.createdAt))}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Relative time
                    Text(
                      _formatRelativeTime(DateTime.parse(doc.createdAt)),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Verification badge
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: HexColor('#3CA442').withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.verified_rounded,
                    color: HexColor('#3CA442'),
                    size: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Verified',
                  style: TextStyle(
                    fontSize: 10,
                    color: HexColor('#3CA442'),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 16),
          ],
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