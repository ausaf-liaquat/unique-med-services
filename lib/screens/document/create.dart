import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/core/http.dart';
import 'package:ums_staff/screens/document/models.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/inputs/text_field.dart';
import 'package:ums_staff/widgets/messages/snack_bar.dart';
import '../../shared/utils/image_picker.dart';
import '../../shared/utils/initial_data.dart';
import '../../widgets/others/back_layout.dart';
import '../../widgets/inputs/date_field.dart';
import '../../widgets/inputs/select_field.dart';

class CreateDocumentScreen extends StatefulWidget {
  const CreateDocumentScreen({super.key});
  static const route = 'document/upload';

  @override
  State<CreateDocumentScreen> createState() => _CreateDocumentScreenState();
}

class DocType {
  late int id;
  late String name;
  DocType({required this.id, required this.name});
  static Iterable<DocType> getList(List<dynamic> data) {
    return data.map((e) => DocType(id: e['id'], name: e['name']));
  }
}

class _CreateDocumentScreenState extends State<CreateDocumentScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  File? _documentFile;
  bool loading = false;
  Iterable<DocType> docTypeList = [];
  DateTime? _selectedExpiryDate;

  void changeSelectValue(String name, String value) {
    _formKey.currentState!.fields[name]!.didChange(value);
  }

  @override
  void initState() {
    super.initState();
    _loadDocumentTypes();
  }

  void _loadDocumentTypes() {
    var http = HttpRequest();
    setState(() {
      loading = true;
    });
    http.docType().then((value) {
      setState(() {
        loading = false;
      });
      if (!value.success) {
        SnackBarMessage.errorSnackbar(context, value.message);
      } else {
        var docType = value.data['data']['document_types'];
        if (docType != null) {
          setState(() {
            docTypeList = DocType.getList(docType);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: HexColor('#6505A3'),
              size: 18,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Upload Document',
          style: TextStyle(
            color: HexColor('#6505A3'),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Information Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HexColor('#FFFBF2'),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: HexColor('#F9D649').withOpacity(0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: HexColor('#B38B1C'),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Uploaded documents will be verified by staff member before they are visible to both nurses and facilities',
                      style: TextStyle(
                        color: HexColor('#B38B1C'),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Form Section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: FormBuilder(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState!.save();
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  initialValue: const {
                    'document_type_id': '',
                    'title': "",
                    "notes": '',
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Document Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#6505A3'),
                        ),
                      ),
                      const SizedBox(height: 24),

                      AppSelectField(
                        error: _formKey.currentState?.fields['document_type_id']?.errorText,
                        title: 'Document Type',
                        bottom: 20,
                        onSelect: changeSelectValue,
                        option: docTypeList.map((e) => e.name).toList(),
                        name: 'document_type_id',
                        label: 'Select Document Type',
                      ),

                      AppTextField(
                        type: TextInputType.text,
                        name: 'title',
                        label: "Document Title",
                        bottom: 20,
                        error: _formKey.currentState?.fields['title']?.errorText,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: 'Title is required')
                        ]),
                      ),

                      // Expiry Date Field - EXACT SAME UI as other fields
                      _buildExpiryDateField(),

                      AppTextField(
                        type: TextInputType.multiline,
                        name: 'notes',
                        label: "Additional Notes",
                        bottom: 20,
                        // maxLines: 3,
                      ),

                      const SizedBox(height: 24),

                      // Document Preview Section
                      _buildDocumentPreview(),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Action Buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  // Expiry Date Field with EXACT same UI as AppTextField
  Widget _buildExpiryDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Expiry Date',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        GestureDetector(
          onTap: _showDatePicker,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: _selectedExpiryDate != null ? HexColor('#6505A3') : Colors.grey[400],
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _selectedExpiryDate != null
                        ? DateFormat('MMM dd, yyyy').format(_selectedExpiryDate!)
                        : 'Select expiry date (optional)',
                    style: TextStyle(
                      color: _selectedExpiryDate != null ? Colors.black87 : Colors.grey[500],
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey[400],
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedExpiryDate ?? DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedExpiryDate = picked;
      });
    }
  }

  Widget _buildDocumentPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Document Preview',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 16),

        GestureDetector(
          onTap: _selectDocument,
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[50],
            ),
            child: _documentFile == null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.attach_file,
                  color: Colors.grey[400],
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  'No document selected',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap to select any file (PDF, Word, Excel, Image, etc.)',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getFileIcon(_documentFile!.path),
                  color: HexColor('#6505A3'),
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  _getFileName(_documentFile!.path),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  _getFileSize(_documentFile!),
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconData _getFileIcon(String filePath) {
    final extension = filePath.toLowerCase().split('.').last;
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _getFileName(String path) {
    return path.split('/').last;
  }

  String _getFileSize(File file) {
    final size = file.lengthSync();
    if (size < 1024) {
      return '$size B';
    } else if (size < 1048576) {
      return '${(size / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(size / 1048576).toStringAsFixed(1)} MB';
    }
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: _selectDocument,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: HexColor('#6505A3'),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: HexColor('#6505A3'),
                  width: 1.5,
                ),
              ),
            ),
            icon: Icon(
              _documentFile == null ? Icons.attach_file : Icons.change_circle_outlined,
              size: 20,
            ),
            label: Text(
              _documentFile == null ? 'SELECT DOCUMENT' : 'CHANGE DOCUMENT',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        if (_documentFile != null) ...[
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: loading ? null : _uploadDocument,
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor('#6505A3'),
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBackgroundColor: Colors.grey[400],
              ),
              icon: loading
                  ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : const Icon(Icons.cloud_upload_outlined, size: 20),
              label: loading
                  ? const Text('UPLOADING...')
                  : const Text(
                'UPLOAD DOCUMENT',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _selectDocument() {
    // Use file_picker package for any file type
    ImagePick.pickerFile(context, (File file) {
      setState(() {
        _documentFile = file;
      });
    });
  }

  void _uploadDocument() {
    if (_formKey.currentState?.validate() ?? false) {
      var body = {..._formKey.currentState?.value ?? {}};
      var formatBody = body.map<String, String>((key, value) {
        if (key == 'document_type_id') {
          var dt = docTypeList.firstWhere((element) => element.name == value);
          return MapEntry(key, dt.id.toString());
        }
        return MapEntry(key, value.toString());
      });

      // Add expiry date to the request body
      if (_selectedExpiryDate != null) {
        formatBody['expiry_date'] = DateFormat('yyyy-MM-dd').format(_selectedExpiryDate!);
      }

      if (_documentFile != null) {
        formatBody['file'] = _documentFile!.path;
      }

      var http = HttpRequest();
      setState(() {
        loading = true;
      });

      http.uploadDoc(formatBody).then((value) {
        setState(() {
          loading = false;
        });

        if (value.success == true) {
          SnackBarMessage.successSnackbar(context, "Document uploaded successfully!");
          Navigator.pop(context);
        } else {
          SnackBarMessage.errorSnackbar(context, value.message);
        }
      });
    }
  }
}