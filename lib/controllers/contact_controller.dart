import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactController extends GetxController {
  void copyToClipboard(String value) {
    FlutterClipboard.copy(value).then((_) {
      Fluttertoast.showToast(msg: 'Copied to clipboard');
    });
  }

  Future<void> launchLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Fluttertoast.showToast(msg: 'Could not open link');
    }
  }
}
