import 'dart:io';
import 'package:forui/forui.dart';
import 'package:flutter/material.dart';
import 'package:identity/model/user.dart';
import 'package:disclosure/disclosure.dart';
import 'package:identity/constants/text.dart';
import 'package:identity/components/snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:identity/constants/transformer.dart';
import 'package:identity/services/url_launcher.dart';

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
                    style: FDialogStyle(
                      horizontalStyle: FDialogContentStyle(
                        titleTextStyle: TextStyle(),
                        bodyTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        padding: EdgeInsets.all(20.0),
                        actionPadding: double.minPositive,
                      ),

                      verticalStyle: FDialogContentStyle(
                        titleTextStyle: TextStyle(),
                        bodyTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        padding: EdgeInsets.all(20.0),
                        actionPadding: double.minPositive,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    direction: Axis.horizontal,
                    body: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: const Text(deleteWarning),
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          cancel,
                          style: TextStyle(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.onSecondaryContainer,
                          ),
                        ),
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
                        child: Text(delete),
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
                        onPressed: () async {
                          var result = await sendSms(user.mobile);
                          if (context.mounted && result == false) {
                            snackBar(context, message: launchFailed);
                          }
                        },
                        icon: FIcon(
                          FAssets.icons.messageSquare,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        shortMessage,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          var result = await makePhoneCall(user.mobile);
                          if (context.mounted && result == false) {
                            snackBar(context, message: launchFailed);
                          }
                        },
                        icon: FIcon(
                          FAssets.icons.phoneCall,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        call,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          var result = await sendWhatsapp(user.mobile);
                          if (context.mounted && result == false) {
                            snackBar(context, message: launchFailed);
                          }
                        },
                        icon: FIcon(
                          FAssets.icons.messageCircleReply,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        whatsapp,
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
