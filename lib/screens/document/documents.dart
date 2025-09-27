import 'package:flutter/material.dart';
import 'package:ums_staff/core/http.dart';
import 'package:ums_staff/screens/document/models.dart';
import '../../widgets/card/document.dart';
import '../../widgets/dataDisplay/typography.dart';
import '../../widgets/inputs/search_field.dart';
import '../../widgets/messages/snack_bar.dart';
import '../../widgets/skeleton/document.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  Iterable<Docs> listDoc = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  void _loadDocuments() {
    var http = HttpRequest();
    setState(() {
      loading = true;
    });
    http.docs().then((value) {
      setState(() {
        loading = false;
      });
      if (!value.success) {
        SnackBarMessage.errorSnackbar(context, value.message);
      } else {
        var docType = value.data['data']['documents'];
        if (docType != null) {
          setState(() {
            listDoc = Docs.getDocList(docType);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Column(
          children: [
            // const SearchField(),
            const SizedBox(height: 24),
            loading
                ? ListView.separated(
              itemCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return const DocumentSkeleton();
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const Divider(),
                  ),
            )
                : listDoc.isEmpty
                ? Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/no-document.png',
                    width: 280,
                  ),
                  const SizedBox(height: 28),
                  const AppTypography(text: 'Document not uploaded yet!', size: 18)
                ],
              ),
            )
                : ListView.separated(
              itemCount: listDoc.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 40,
                  ),
                  child: DocumentCard(
                    doc: listDoc.elementAt(index),

                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const Divider(),
                  ),
            )
          ],
        ),
      ),
    );
  }
}