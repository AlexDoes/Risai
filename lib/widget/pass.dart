import 'package:uuid/uuid.dart';
import 'dart:math';

String generatePass({
  String? passColor,
  String? passLanguage,
  String? recentScore,
  String? cardTitle,
  String? password,
}) {
  final String _passId = const Uuid().v4();
  const String _passClass = 'resaipasscard';
  const String _issuerId = '3388000000022316751';
  const String _issuerEmail = 'hankleeflutter@gmail.com';
  String _passColor = passColor ?? '#fff0fe';
  String _passLanguage = passLanguage ?? 'en';
  String _recentScore = recentScore ?? '0';
  String _cardTitle = cardTitle ?? 'Risai Card Alpha';
  String _passUrl = 'https://i.imgur.com/5vpO2yu.png';
  Random random = Random();
  int randomPrize = random.nextInt(10000000) + 1;
  if (randomPrize == 030395 || password == '030395') {
    _cardTitle = 'Risai Card Omega';
    _passColor = '#abdbe3';
    _passUrl = 'https://i.imgur.com/Zzv4R1i.png';
  } else {
    randomPrize %= random.nextInt(9);
  }
  print('randomPrize: $randomPrize');

  List<String> _passColorsArray = [
    '#fff0fe',
    '#abdbe3',
    '#f5f5f5',
  ];

  List<List<String>> _cardDetailsEN = [
    ['Chiply', 'https://i.imgur.com/2Zh9aJ7.png'],
    ['Kofee', 'https://i.imgur.com/50iFO8r.png'],
    ['Risai', 'https://i.imgur.com/FgTmqba.png'],
    ['Moolk', 'https://i.imgur.com/DiZXcK6.png'],
    ['Newsflash', 'https://i.imgur.com/hxjFyRg.png'],
    ['Bagsy', 'https://i.imgur.com/SNIb2Ay.png'],
    ['Poppy', 'https://i.imgur.com/aHuHFiV.png'],
    ['Theodore Portmus', 'https://i.imgur.com/w0bFlu2.png'],
    ['H2 Uh Oh', 'https://i.imgur.com/c3lig6z.png'],
  ];

  List<List<String>> _cardDetailsJP = [
    ['ちぷりちゃん. ', 'https://i.imgur.com/2Zh9aJ7.png'],
    ['こふぃくん', 'https://i.imgur.com/50iFO8r.png'],
    ['りさいちゃん.', 'https://i.imgur.com/FgTmqba.png'],
    ['もーるくくん ', 'https://i.imgur.com/DiZXcK6.png'],
    [' にゅーずふらっしゅ', 'https://i.imgur.com/hxjFyRg.png'],
    ['ばぐしーちゃん', 'https://i.imgur.com/SNIb2Ay.png'],
    ['ぽっぴー', 'https://i.imgur.com/aHuHFiV.png'],
    ['ておどあ P. さま', 'https://i.imgur.com/w0bFlu2.png'],
    ['えいちつーおちゃ', 'https://i.imgur.com/c3lig6z.png'],
  ];

  return """
    {
      "iss": "$_issuerEmail",
      "aud": "google",
      "typ": "savetowallet",
      "origins": [],
      "payload": {
        "genericObjects": [
          {
            "id": "$_issuerId.$_passId",
            "classId": "$_issuerId.$_passClass",
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "$_passColor",
            "logo": {
              "sourceUri": {
                "uri": "https://i.imgur.com/5vpO2yu.png"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "$_passLanguage",
                "value": "$_cardTitle"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "$_passLanguage",
                "value": "Top Cleaner"
              }
            },
            "header": {
              "defaultValue": {
                "language": "$_passLanguage",
                "value": "Hank Lee"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "$_passId.$_recentScore.$randomPrize",
              "alternateText": "Resai as much as you can!"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "$_passUrl"
              }
            },
            "textModulesData": [
              {
                "header": "points",
                "body": "$_recentScore",
                "id": "points"
              }
            ]
          }
        ]
      }
    }
  """;
}

// Usage:
final String examplePass = generatePass();
