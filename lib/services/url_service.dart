import 'package:url_launcher/url_launcher.dart';

class UrlService {
  static Future<void> launch(String link) async {
    final url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
