import 'package:uuid/uuid.dart';
import 'dart:math';
import 'package:reso/localization/language.dart';

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
  String score = passLanguage == 'ja' ? 'スコア' : 'Score';
  String barcodeText = passLanguage == 'ja'
      ? 'リサイ(クルする)してください！'
      : 'Resai(cle) as much as you can!';
  String pointsText = passLanguage == 'ja' ? 'ポイント' : 'Points';
  String titleText = passLanguage == 'ja' ? 'タイトル' : 'Title';
  String header = passLanguage == 'ja' ? 'ざ・わ・る・ど' : 'Hello (the) world';
  // print('Pass Language: $_passLanguage');
  Random random = Random();
  int randomPrize = random.nextInt(10000000) + 1;
  if (randomPrize == 030395 || password == '030395') {
    _cardTitle = passLanguage == 'ja' ? 'リサイ・オメガ' : 'Risai Omega';
    _passColor = '#abdbe3';
    _passUrl = 'https://i.imgur.com/Zzv4R1i.png';
  } else {
    randomPrize %= (random.nextInt(9) + 1);
  }

  List<String> _passColorsArray = [
    '#fff0fe',
    '#abdbe3',
    '#faf2a3',
    '#ffca6f',
    '#F5EEE6',
    '#FFF8E3',
    '#F3D7CA',
    '#E6A4B4',
    '#F3CCF3',
  ];

  List<List<String>> _cardDetailsEN = [
    ['Chiply', 'https://i.imgur.com/2Zh9aJ7.png', 'Potato brethren'],
    ['Kofee', 'https://i.imgur.com/50iFO8r.png', 'Caffeine friend'],
    ['Risai', 'https://i.imgur.com/FgTmqba.png', 'Resai-cle'],
    ['Moolk', 'https://i.imgur.com/DiZXcK6.png', 'Moo-t title'],
    ['Newsflash', 'https://i.imgur.com/hxjFyRg.png', 'Breaking news'],
    ['Bagsy', 'https://i.imgur.com/SNIb2Ay.png', 'Bagguette?'],
    ['Poppy', 'https://i.imgur.com/aHuHFiV.png', 'Poppin Popper'],
    [
      'Theodore Portmus',
      'https://i.imgur.com/w0bFlu2.png',
      'Portly Theodore the Roll'
    ],
    ['H2 Uh Oh', 'https://i.imgur.com/c3lig6z.png', 'Wetto humor'],
  ];

  List<List<String>> _cardDetailsJP = [
    ['ちぷりちゃん. ', 'https://i.imgur.com/2Zh9aJ7.png', 'ポテトの仲間'],
    ['こふぃくん', 'https://i.imgur.com/50iFO8r.png', 'コーヒーじない ?'],
    ['りさいちゃん.', 'https://i.imgur.com/FgTmqba.png', 'リサイ(クル)して'],
    ['もーるくくん ', 'https://i.imgur.com/DiZXcK6.png', '牛になってじない'],
    [' にゅーずふらっしゅ', 'https://i.imgur.com/hxjFyRg.png', 'ニュース速報 !'],
    ['ばぐしーちゃん', 'https://i.imgur.com/SNIb2Ay.png', 'バゲット ?'],
    ['ぽっぴー', 'https://i.imgur.com/aHuHFiV.png', 'ソーダすっかり ?'],
    ['ておどあ P. さま', 'https://i.imgur.com/w0bFlu2.png', 'ロードローラーだ！'],
    ['えいちつーおちゃ', 'https://i.imgur.com/c3lig6z.png', 'ウェットユーモア'],
  ];

  if (_passLanguage == 'ja') {
    _cardTitle = _cardDetailsJP[randomPrize][0];
    _passUrl = _cardDetailsJP[randomPrize][1];
    header = _cardDetailsJP[randomPrize][2];
  } else {
    _cardTitle = _cardDetailsEN[randomPrize][0];
    _passUrl = _cardDetailsEN[randomPrize][1];
    header = _cardDetailsEN[randomPrize][2];
  }

  _passColor = _passColorsArray[random.nextInt(_passColorsArray.length)];

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
                "value": "$titleText"
              }
            },
            "header": {
              "defaultValue": {
                "language": "$_passLanguage",
                "value": "$header"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "$_passId.$_recentScore.$randomPrize",
              "alternateText": "$barcodeText"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "$_passUrl"
              }
            },
            "textModulesData": [
              {
                "header": "$pointsText",
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
