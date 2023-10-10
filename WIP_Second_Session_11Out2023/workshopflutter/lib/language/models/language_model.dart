import 'dart:convert';

import 'package:equatable/equatable.dart';

class LanguageModel extends Equatable {
  final String languageName;
  final String languageCode;
  final String countryCode;

  const LanguageModel({
    required this.languageName,
    required this.languageCode,
    required this.countryCode,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> jsonData) =>
      LanguageModel(
        languageName: jsonData['languageName'],
        languageCode: jsonData['languageCode'],
        countryCode: jsonData['countryCode'],
      );

  static Map<String, dynamic> toMap(LanguageModel model) => <String, dynamic>{
        'languageName': model.languageName,
        'languageCode': model.languageCode,
        'countryCode': model.countryCode,
      };

  static String serialize(LanguageModel model) =>
      json.encode(LanguageModel.toMap(model));

  static LanguageModel deserialize(String json) =>
      LanguageModel.fromJson(jsonDecode(json));

  @override
  List<Object?> get props => [languageName, languageCode, countryCode];
}
