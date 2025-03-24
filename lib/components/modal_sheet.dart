import 'package:forui/forui.dart';
import 'package:flutter/material.dart';
import 'package:identity/constants/text.dart';
import 'package:identity/components/snack_bar.dart';
import 'package:identity/services/shared_pref.dart';
import 'package:identity/services/url_launcher.dart';

void bottomsheet(BuildContext context, data, {required bool dbCall}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (_) {
      var name = data.name;
      var mobile = data.mobile;
      var pref = SharedPref.get();
      // print({"pref": pref});

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
              if (dbCall == false && pref == false)
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
                              style: FDialogStyle(
                                horizontalStyle: FDialogContentStyle(
                                  titleTextStyle: TextStyle(),
                                  bodyTextStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                  padding: EdgeInsets.all(20.0),
                                  actionPadding: double.minPositive,
                                ),

                                verticalStyle: FDialogContentStyle(
                                  titleTextStyle: TextStyle(),
                                  bodyTextStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                  padding: EdgeInsets.all(20.0),
                                  actionPadding: double.minPositive,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onInverseSurface,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              direction: Axis.horizontal,
                              body: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Contact is not saved. ',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    children: const <TextSpan>[
                                      TextSpan(text: 'Go to '),
                                      TextSpan(
                                        text: 'Settings ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'to enable contact auto-save feature.',
                                      ),
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
