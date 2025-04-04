import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:identity/schema/user.dart';
import 'package:signals/signals_flutter.dart';
import 'package:identity/services/http_client.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import 'package:identity/model/user.dart';
import 'package:identity/services/getit.dart';
import 'package:identity/constants/text.dart';
import 'package:identity/constants/theme.dart';
import 'package:identity/constants/styles.dart';
import 'package:identity/services/shared_pref.dart';
import 'package:identity/constants/transformer.dart';
import 'package:identity/utils/theme_transformer.dart';
import 'package:identity/components/border_animate.dart';
import 'package:identity/components/dialogs/dialog.dart';
import 'package:identity/components/dialogs/bottom_sheet.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  String? mobileField;
  bool isLoading = false;
  bool _submitted = false;

  var chipValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setSetState() {
    setState(() {
      _submitted = true;
      isLoading = true;
    });
  }

  void updateSetState() {
    setState(() {
      isLoading = false;
      _submitted = false;
    });
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      setSetState();
      checkAvailability();
    }
  }

  checkAvailability() {
    final (user: user, message: message) = UserModel().findUser(mobileField);

    if (message == false) {
      return getName();
    }

    updateSetState();
    _controller.text = '';
    if (mounted) bottomsheet(context, user, savedContact: true);
  }

  Future getName() async {
    var code = getbankCode(mobileField);
    var results = await getID(mobileField, code);

    if (results[status] == false) {
      updateSetState();
      showFailedResponse(results[message]);
    } else {
      updateSetState();
      writetoDB(results[data]);
      _controller.text = '';
    }
  }

  void writetoDB(data) {
    final user = User(
      data[accountNumber],
      data[accountName],
      grabInitials(data[accountName]),
      getbankCode(data[accountNumber]),
      data[bankId],
    );

    var saveContact = getIt.get<SaveContact>();
    if (saveContact.state.value == false) {
      if (mounted) bottomsheet(context, user);
      return;
    }

    UserModel().writeUser(user);
    if (mounted) bottomsheet(context, user);
  }

  void showFailedResponse(response) {
    if (mounted) dialog(context, response);
  }

  @override
  Widget build(BuildContext context) {
    final themer = getIt.get<Themer>();
    var saveContact = getIt.get<SaveContact>();
    var pref = SharedPref.get();
    saveContact.state.value = pref;

    SliverWoltModalSheetPage page1(BuildContext modalSheetContext) {
      return WoltModalSheetPage(
        hasSabGradient: false,
        isTopBarLayerAlwaysVisible: false,
        trailingNavBarWidget: IconButton(
          icon: const Icon(Icons.close),
          onPressed: Navigator.of(modalSheetContext).pop,
        ),
        child: Column(
          children: [
            ListTile(
              title: const Text(saveContacts),
              trailing: Watch(
                (context) => Switch(
                  value: saveContact.state.value,
                  onChanged: (value) {
                    saveContact.state.value = value;
                    SharedPref.setValue(value);
                  },
                ),
              ),
            ),
            ListTile(
              onTap: WoltModalSheet.of(modalSheetContext).showNext,
              title: Text(appearance),
            ),

            SizedBox(height: 20),
          ],
        ),
      );
    }

    SliverWoltModalSheetPage page2(BuildContext modalSheetContext) {
      return WoltModalSheetPage(
        useSafeArea: true,
        enableDrag: false,
        hasSabGradient: false,
        isTopBarLayerAlwaysVisible: true,
        hasTopBarLayer: false,
        leadingNavBarWidget: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: WoltModalSheet.of(modalSheetContext).showPrevious,
        ),
        child: Padding(
          padding: pagePadding,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    themeInfo.asMap().entries.map((entry) {
                      return Watch(
                        (context) => BorderAnimate(
                          strokeWidth: 10,
                          showBlur: false,
                          colors:
                              chipValue == entry.key
                                  ? [
                                    Colors.lightBlueAccent,
                                    Colors.lightBlueAccent,
                                    const Color.fromARGB(255, 154, 217, 247),
                                    Colors.lightBlueAccent,
                                  ]
                                  : [Colors.transparent],
                          child: ChoiceChip(
                            autofocus: true,
                            showCheckmark: false,
                            side: BorderSide(color: Colors.transparent),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(buttonRadius),
                            ),
                            label: Container(
                              alignment: Alignment.center,
                              width: 60.0,
                              height: 100.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  icons[entry.key],
                                  Text(
                                    textAlign: TextAlign.center,
                                    entry.value.last.toString(),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                            selected:
                                themer.state.value ==
                                themeDecoder(themeDecoder),
                            onSelected: (bool selected) {
                              chipValue = selected ? entry.key : entry.key;
                              themer.state.value = themeTransformer(
                                number: chipValue,
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(search),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              tooltip: settings,
              onPressed: () {
                WoltModalSheet.show<void>(
                  context: context,
                  pageListBuilder: (modalSheetContext) {
                    return [page1(modalSheetContext), page2(modalSheetContext)];
                  },
                );
              },
              icon: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Form(
                autovalidateMode:
                    _submitted
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                key: _formKey,
                child: Column(
                  spacing: 10,
                  children: [
                    TextFormField(
                      autofocus: true,
                      maxLines: 1,
                      maxLength: 10,
                      controller: _controller,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: dummyMobile,
                        fillColor: Theme.of(context).colorScheme.onTertiary,
                        filled: true,
                        suffixIcon: IconButton(
                          color: Theme.of(context).colorScheme.primary,
                          icon: Icon(Icons.close),
                          onPressed:
                              () => {
                                setState(() {
                                  _submitted = false;
                                  _controller.text = '';
                                }),
                              },
                        ),
                        border: InputBorder.none,
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            inputBorderRadius,
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            inputBorderRadius,
                          ),
                          borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.primaryFixedDim,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            inputBorderRadius,
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                      autofillHints: const [AutofillHints.telephoneNumberLocal],
                      autovalidateMode:
                          _submitted
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return blankEntry;
                        }

                        if (value.length < 10) {
                          return invalidEntry;
                        }

                        mobileField = value;
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        TextInput.finishAutofillContext();
                        submit();
                      },
                    ),
                    FilledButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          Size(double.infinity, 50.0),
                        ),
                      ),
                      child:
                          isLoading
                              ? CircularProgressIndicator(
                                strokeWidth: 3.5,
                                color: Theme.of(context).colorScheme.onPrimary,
                              )
                              : Text(
                                search,
                                style: TextStyle(
                                  fontSize:
                                      Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.fontSize,
                                ),
                              ),
                      onPressed: () => submit(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
