import 'package:url_launcher/url_launcher.dart';

import '../../widgets/messages/snack_bar.dart';

class WebRedirect {
  Future<void> privacyPolicy(dynamic context) async {
    final Uri url = Uri(scheme: 'https', host: 'www.uniquemedsvcs.com', path: 'PRIVACY%20POLICIES.pdf');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      SnackBarMessage.errorSnackbar(context, 'Some thing went Wrong!');
    }
  }

  Future<void> physicalForm(dynamic context) async {
    final Uri url = Uri(scheme: 'https', host: 'www.uniquemedsvcs.com', path: 'Physical%20Form.pdf');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      SnackBarMessage.errorSnackbar(context, 'Some thing went Wrong!');
    }
  }

  Future<void> annualForm(dynamic context) async {
    final Uri url = Uri(scheme: 'https', host: 'www.uniquemedsvcs.com', path: 'Annual%20Physical%20Form.pdf');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      SnackBarMessage.errorSnackbar(context, 'Some thing went Wrong!');
    }
  }

  Future<void> testForm(dynamic context) async {
    final Uri url = Uri(scheme: 'https', host: 'www.uniquemedsvcs.com', path: 'TB%20Test%20Results%20form.pdf');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      SnackBarMessage.errorSnackbar(context, 'Some thing went Wrong!');
    }
  }

  Future<void> timeSlip(dynamic context) async {
    final Uri url = Uri(scheme: 'https', host: 'www.uniquemedsvcs.com', path: 'UMS_Staffing_Timeslip.pdf');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      SnackBarMessage.errorSnackbar(context, 'Some thing went Wrong!');
    }
  }

  Future<void> termsAndConditions(dynamic context) async {
    final Uri url = Uri(scheme: 'https', host: 'www.uniquemedsvcs.com', path: 'TERMS%20OF%20AGREEMENT.pdf');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      SnackBarMessage.errorSnackbar(context, 'Some thing went Wrong!');
    }
  }

  Future<void> smsTermsAndConditions(dynamic context) async {
    final Uri url = Uri(scheme: 'https', host: 'www.gmail.com', path: 'SMS%20TERMS.pdf');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      SnackBarMessage.errorSnackbar(context, 'Some thing went Wrong!');
    }
  }

  Future<void> supportPhoneCall(dynamic context) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '9415291867',
    );

    canLaunchUrl(launchUri).then((bool result) async {
      if (result == true) {
        await launchUrl(launchUri);
      } else {
        SnackBarMessage.errorSnackbar(context, 'Some thing went Wrong!');
      }
    });
  }

  Future<void> supportEmail(dynamic context) async {
    final Uri url = Uri(scheme: 'mailto', path: 'info@uniquemedsvcs.com', queryParameters: {'subject': '', 'body': ''});

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      SnackBarMessage.errorSnackbar(context, 'Some thing went Wrong!');
    }
  }
}
