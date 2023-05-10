import 'package:url_launcher/url_launcher.dart';

class WebRedirect {
  Future<void> privacyPolicy() async {
    final Uri url = Uri(
        scheme: 'https',
        host: 'www.uniquemedsvcs.com',
        path: 'PRIVACY%20POLICIES.pdf');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Some thing went Wrong!');
    }
  }

  Future<void> termsAndConditions() async {
    final Uri url = Uri(
        scheme: 'https',
        host: 'www.uniquemedsvcs.com',
        path: 'TERMS%20OF%20AGREEMENT.pdf');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Some thing went Wrong!');
    }
  }

  Future<void> smsTermsAndConditions() async {
    final Uri url = Uri(
        scheme: 'https',
        host: 'www.uniquemedsvcs.com',
        path: 'SMS%20TERMS.pdf');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Some thing went Wrong!');
    }
  }
}
