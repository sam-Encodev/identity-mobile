import 'dart:io';
import 'package:forui/forui.dart';
import 'package:flutter/material.dart';
import 'package:identity/model/user.dart';
import 'package:disclosure/disclosure.dart';
import 'package:identity/constants/text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:identity/components/snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:identity/constants/transformer.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key, required this.users});
  final List users;

  @override
  State<ContactList> createState() => ContactListState();
}

class ContactListState extends State<ContactList> {
 

  @override
  void initState() {
    super.initState();
  }

  Future<void> _sendSms(String contact) async {
    var mobile = mobileTransformer(contact);
    final Uri launchUri = Uri(scheme: 'sms', path: "+$mobile");

    if (await canLaunchUrl(launchUri)) {
      launchUrl(launchUri, mode: LaunchMode.externalNonBrowserApplication);
    } else {
      // throw launchFailed;
      if (mounted) {
        snackBar(context, message: launchFailed);
      }
    }
  }

  Future<void> _makePhoneCall(String contact) async {
    var mobile = mobileTransformer(contact);
    final Uri launchUri = Uri(scheme: 'tel', path: "+$mobile");

    if (await canLaunchUrl(launchUri)) {
      launchUrl(launchUri, mode: LaunchMode.externalNonBrowserApplication);
    } else {
      // throw launchFailed;
      if (mounted) {
        snackBar(context, message: launchFailed);
      }
    }
  }

  Future<void> _sendWhatsapp(String contact) async {
    var mobile = mobileTransformer(contact);
    final Uri launchUri = Uri.parse(
      Uri.encodeFull("https://wa.me/$mobile?text=Hi, I need some help."),
    );

    if (await canLaunchUrl(launchUri)) {
      launchUrl(launchUri, mode: LaunchMode.externalNonBrowserApplication);
    } else {
      // throw launchFailed;
      if (mounted) {
        snackBar(context, message: launchFailed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DisclosureGroup(
      multiple: false,
      clearable: true,
      children: List<Widget>.generate(widget.users.length.toInt(), (index) {
        final user = widget.users[index];
        return GestureDetector(
          onLongPress: () {
            showAdaptiveDialog(
              context: context,
              builder:
                  (context) => FDialog(
                    direction: Axis.horizontal,
                    body: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: const Text(
                        'This action cannot be undone. This will permanently delete the account.',
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FilledButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).colorScheme.error,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          UserModel().deleteUser(user.mobile);
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  ),
            );
          },
          child: Disclosure(
            key: ValueKey(index),
            wrapper: (state, child) {
              return Card.filled(
                color: Theme.of(context).colorScheme.inversePrimary,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: child,
              );
            },
            header: DisclosureButton(
              child: Padding(
                padding:
                    Platform.isIOS
                        ? const EdgeInsets.symmetric(vertical: 3)
                        : const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: FAvatar.raw(
                    style: FAvatarStyle(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    child: Text(grabInitials(user.name)),
                  ),
                  title: AutoSizeText(
                    user.name.toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize,
                    ),
                    minFontSize: Platform.isIOS ? 14 : 20,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            divider: const Divider(height: 1),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          _sendSms(user.mobile);
                        },
                        icon: FIcon(
                          FAssets.icons.messageSquare,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        "Message",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          _makePhoneCall(user.mobile);
                        },
                        icon: FIcon(
                          FAssets.icons.phoneCall,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        "Call",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          _sendWhatsapp(user.mobile);
                        },
                        icon: FIcon(
                          FAssets.icons.messageCircleReply,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        "Whatsapp",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
