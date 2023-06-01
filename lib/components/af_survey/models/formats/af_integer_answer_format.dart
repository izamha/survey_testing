import 'package:survey_testing/components/af_survey/models/formats/af_answer_format.dart';

class AfIntegerAnswerFormat implements AfAnswerFormat {
  final int? defaultValue;
  final String hint;

  const AfIntegerAnswerFormat({
    this.defaultValue,
    this.hint = '',
  }) : super();

  AfIntegerAnswerFormat.fromJson(Map<String, dynamic> json)
      : defaultValue = json['defaultValue'],
        hint = json['hint'];

  @override
  Map<String, dynamic> toJson() => {
        'default_value': defaultValue,
        'hint': hint,
      };
}
