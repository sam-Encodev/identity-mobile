import 'package:forui/forui.dart';
import 'package:flutter/material.dart';
import 'package:identity/constants/text.dart';
import 'package:identity/components/snack_bar.dart';
import 'package:identity/services/url_launcher.dart';

void bottomsheet(BuildContext context, data) {
  showModalBottomSheet<void>(
    context: context,
    builder: (_) {
      var name = data.name;
      var mobile = data.mobile;

      return SizedBox(
        height: 320,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListView(
            children: [
              ListTile(
                onTap: () {},
                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                minVerticalPadding: 0,
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ListTile(title: Text(name)),
              ListTile(
                leading: FIcon(FAssets.icons.messageSquare, color: Colors.grey),
                title: const Text(text),
                onTap: () async {
                  var result = await sendSms(mobile);
                  if (context.mounted && result == false) {
                    snackBar(context, message: launchFailed);
                  }
                },
              ),
              ListTile(
                leading: FIcon(FAssets.icons.phoneCall, color: Colors.grey),
                title: const Text(call),
                onTap: () async {
                  var result = await makePhoneCall(mobile);
                  if (context.mounted && result == false) {
                    snackBar(context, message: launchFailed);
                  }
                },
              ),
              ListTile(
                leading: FIcon(
                  FAssets.icons.messageCircleReply,
                  color: Colors.grey,
                ),
                title: const Text(whatsapp),
                onTap: () async {
                  var result = await sendWhatsapp(mobile);
                  if (context.mounted && result == false) {
                    snackBar(context, message: launchFailed);
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
