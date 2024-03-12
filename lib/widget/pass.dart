import 'package:uuid/uuid.dart';

final String _passId = const Uuid().v4();
const String _passClass = 'resaipasscard';
const String _issuerId = '3388000000022316751';
const String _issuerEmail = 'hankleeflutter@gmail.com';
const String _passColor = '#fff0fe';
const String _passLanguage = 'en';
const String _recentScore = '0';
const String _cardTitle = 'Risai Card Alpha';

final String examplePass = """ 
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
              "value": "$_passId"
              "alternateText": "Resai as much as you can!",
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://i.imgur.com/5vpO2yu.png"
              }
            },
            "textModulesData": [
              {
                "header": "point",
                "body": "$_recentScore",
                "id": "points"
              }
            ]
          }
        ]
      }
    }
""";
