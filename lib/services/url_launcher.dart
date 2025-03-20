import 'package:identity/constants/text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:identity/constants/transformer.dart';

Future<bool> sendSms(String contact) async {
  var mobile = mobileTransformer(contact);
  final Uri launchUri = Uri(scheme: sms, path: "+$mobile");

  if (await canLaunchUrl(launchUri)) {
    launchUrl(launchUri, mode: LaunchMode.externalNonBrowserApplication);
    return true;
  } else {
    return false;
  }
}

Future<bool> makePhoneCall(String contact) async {
  var mobile = mobileTransformer(contact);
  final Uri launchUri = Uri(scheme: tel, path: "+$mobile");

  if (await canLaunchUrl(launchUri)) {
    launchUrl(launchUri, mode: LaunchMode.externalNonBrowserApplication);
    return true;
  } else {
    return false;
  }
}

Future<bool> sendWhatsapp(String contact) async {
  var mobile = mobileTransformer(contact);
  final Uri launchUri = Uri.parse(
    Uri.encodeFull("$whatsappUrl/$mobile?text$whatsappMessage"),
  );

  if (await canLaunchUrl(launchUri)) {
    launchUrl(launchUri, mode: LaunchMode.externalNonBrowserApplication);
    return true;
  } else {
    return false;
  }
}
