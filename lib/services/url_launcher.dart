import 'package:url_launcher/url_launcher.dart';
import 'package:identity/constants/transformer.dart';

Future<bool> sendSms(String contact) async {
  var mobile = mobileTransformer(contact);
  final Uri launchUri = Uri(scheme: 'sms', path: "+$mobile");

  if (await canLaunchUrl(launchUri)) {
    launchUrl(launchUri, mode: LaunchMode.externalNonBrowserApplication);
    return true;
  } else {
    // throw launchFailed;
    return false;
  }
}

Future<bool> makePhoneCall(String contact) async {
  var mobile = mobileTransformer(contact);
  final Uri launchUri = Uri(scheme: 'tel', path: "+$mobile");

  if (await canLaunchUrl(launchUri)) {
    launchUrl(launchUri, mode: LaunchMode.externalNonBrowserApplication);
    return true;
  } else {
    // throw launchFailed;
    return false;
  }
}

Future<bool> sendWhatsapp(String contact) async {
  var mobile = mobileTransformer(contact);
  final Uri launchUri = Uri.parse(
    Uri.encodeFull("https://wa.me/$mobile?text=Hi, I need some help."),
  );

  if (await canLaunchUrl(launchUri)) {
    launchUrl(launchUri, mode: LaunchMode.externalNonBrowserApplication);
    return true;
  } else {
    // throw launchFailed;
    return false;
  }
}
