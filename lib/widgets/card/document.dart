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
    return AppCard(
        padding: const EdgeInsets.only(right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
              child: Container(
                  color: AppColorScheme().black6,
                  width: 75,
                  height: 75,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const SkeletonAvatar(style: SkeletonAvatarStyle(width: 75, height: 75, borderRadius: BorderRadius.zero)),
                    fit: BoxFit.cover,
                    imageUrl: doc.documentUrl ?? '',
                    errorWidget: (context, url, error) => Image.asset('assets/images/document-not-found.png', fit: BoxFit.cover),
                  )),
            ),
            const SizedBox(width: 24),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                AppTypography(
                  align: TextAlign.start,
                  text: doc.title,
                  overflow: TextOverflow.ellipsis,
                  size: 18,
                  color: AppColorScheme().black90,
                  weight: FontWeight.w500,
                ),
                const SizedBox(height: 8),
                // document type
                doc.documentType!.name == null
                    ? Container()
                    : RowItem(
                        icon: Icons.document_scanner_outlined,
                        text: doc.documentType!.name!,
                        textColor: AppColorScheme().black60,
                        iconColor: AppColorScheme().black60,
                      ),

                RowItem(
                  icon: Icons.auto_delete_outlined,
                  text: DateFormat('MMM dd, yyyy').format(DateTime.parse(doc.createdAt)),
                  textColor: AppColorScheme().black60,
                  iconColor: Theme.of(context).colorScheme.error,
                )
              ],
            )),
            const SizedBox(width: 8),
            Icon(
              Icons.verified,
              color: HexColor('#3CA442'),
              size: 24,
            )
          ],
        ));
  }
}
