import 'package:forui/forui.dart';
import 'package:flutter/material.dart';
import 'package:identity/constants/text.dart';
import 'package:identity/constants/styles.dart';
import 'package:identity/components/snack_bar.dart';
import 'package:identity/services/shared_pref.dart';
import 'package:identity/services/url_launcher.dart';

void bottomsheet(BuildContext context, data, {savedContact = false}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (_) {
      var name = data.name;
      var mobile = data.mobile;
      var pref = SharedPref.get();

      return SizedBox(
        height: 320,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListView(
            children: [
              if (savedContact == true && pref == true)
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
              if (savedContact == false && pref == false)
                ListTile(
                  onTap: () {},
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  minVerticalPadding: 0,
                  trailing: IconButton(
                    icon: const Icon(Icons.info_outline_rounded),
                    onPressed: () {
                      showAdaptiveDialog<void>(
                        context: context,
                        builder:
                            (context) => FDialog(
                              style: fDialogStyles(context),
                              direction: Axis.horizontal,
                              body: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: autoSaveMessage1,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    children: const <TextSpan>[
                                      TextSpan(text: autoSaveMessage2),
                                      TextSpan(
                                        text: settings,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: autoSaveMessage4),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                FilledButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(close),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                ),
              ListTile(
                title: Text(
                  name,
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),
              ),
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
