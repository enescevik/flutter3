import 'package:flutter/material.dart';

class LanguageModel {
  static final List<Language> languages = [
    const Language(1, 'Türkçe', Locale('tr', 'TR')),
    const Language(2, 'English', Locale('en', 'US'))
  ];
}

@immutable
class Language {
  final int id;
  final String name;
  final Locale locale;

  const Language(this.id, this.name, this.locale);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Language && other.id == id;
}
