import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class LinkService {
  static final FirebaseDynamicLinks _firebaseDynamicLinks =
      FirebaseDynamicLinks.instance;

  static Future<Uri> createDynamicLink(String taskId) {
    final parameters = DynamicLinkParameters(
      uriPrefix: 'https://todoserverless.page.link',
      link: Uri.parse('https://todoserverless.page.link/view?taskId=$taskId'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.to_do_serverless',
        minimumVersion: 0,
      ),
    );

    return _firebaseDynamicLinks.buildLink(parameters);
  }
}
