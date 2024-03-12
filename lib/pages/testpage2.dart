import 'package:flutter/material.dart';
import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:reso/widget/pass.dart';
import 'package:reso/localization/language.dart';
import 'package:provider/provider.dart';
import 'package:reso/providers/languageprovider.dart';

class Testpage2 extends StatelessWidget {
  void _showSnackBar(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  @override
  Widget build(BuildContext context) {
    var currentLanguage = Provider.of<LanguageProvider>(context).language;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AddToGoogleWalletButton(
              pass: examplePass,
              onSuccess: () => _showSnackBar(context, 'Success!'),
              onCanceled: () => _showSnackBar(context, 'Action canceled.'),
              onError: (Object error) =>
                  _showSnackBar(context, error.toString()),
              locale: Locale.fromSubtags(
                languageCode: currentLanguage == 'Japanese' ? 'jp' : 'en',
                countryCode: 'US',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
