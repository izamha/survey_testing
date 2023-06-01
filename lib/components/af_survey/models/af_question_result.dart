import 'package:equatable/equatable.dart';

class AfQuestionResult extends Equatable {
  /// The parameter that contains the data partaining to a question.
  final String questionText;

  /// The list of questions that followed after a particular answer.
  late final List<AfQuestionResult> children;

  /// The list of answers selected by the user.
  late final List<String> answers;

  AfQuestionResult({
    required this.questionText,
    List<String>? answers,
  })  : answers = answers ?? [],
        children = [];

  AfQuestionResult.fromJson(Map<String, dynamic> json)
      : questionText = json['question_text'],
        children = (json['children'] as List<dynamic>)
            .map((e) => AfQuestionResult.fromJson(e as Map<String, dynamic>))
            .toList(),
        answers = json['answers'];

  Map<String, dynamic> toJson() => {
        'question_text': questionText,
        'children': children.map((e) => e.toJson()).toList(),
        'answers': answers,
      };

  @override
  List<Object?> get props => [questionText, answers, children];
}
