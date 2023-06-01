import 'package:survey_kit/survey_kit.dart';

import 'af_integer_answer_format.dart';

abstract class AfAnswerFormat {
  const AfAnswerFormat();

  factory AfAnswerFormat.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'integer':
        return AfIntegerAnswerFormat.fromJson(json);
      default:
        throw const AnswerFormatNotDefinedException();
    }
  }
  Map<String, dynamic> toJson();
}
