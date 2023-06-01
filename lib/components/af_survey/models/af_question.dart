import 'package:equatable/equatable.dart';

class AfQuestion extends Equatable {
  /// The parameter that contains the data partaining to a question.
  final String questionText;

  /// The parameter that indecates the wether question is a single choice or multiple choice.
  final bool singleChoice;

  /// Configure the list of possible answer choices and their corresponding list of [AfQuestion] objects that follow.
  final Map<String, List<AfQuestion>?> answerChoices;

  /// If set to true the validation of the form fails
  final bool isMandatory;

  /// The default error text to be shown upon failing the validation
  final String? errorText;

  /// Custom properties for every question/field.
  final Map<String, dynamic>? properties;

  /// The list of answers selected by the user
  late final List<String> answers;

  AfQuestion({
    required this.questionText,
    this.singleChoice = true,
    Map<String, List<AfQuestion>?>? answerChoices,
    this.isMandatory = false,
    this.errorText,
    this.properties,
    List<String>? answers,
  })  : answers = answers ?? [],
        answerChoices = answerChoices ?? {},
        assert(
            properties != null && answerChoices!.isEmpty || properties == null);

  AfQuestion.fromJson(Map<String, dynamic> json)
      : questionText = json['question_text'],
        singleChoice = json['single_choice'],
        answerChoices = (json['answer_choices'] as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            k,
            (e as List<dynamic>?)
                ?.map((e) => AfQuestion.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        ),
        isMandatory = json['is_mandatory'] as bool? ?? false,
        errorText = json['error_text'],
        properties = json['properties'],
        answers = json['answers'];

  Map<String, dynamic> toJson() => {
        'question_text': questionText,
        'single_choice': singleChoice,
        'answer_choices': answerChoices
            .map((key, e) => MapEntry(key, e?.map((e) => e.toJson()).toList())),
        'is_mandatory': isMandatory,
        'error_text': errorText,
        'properties': properties,
        'answers': answers,
      };

  @override
  List<Object?> get props =>
      [questionText, singleChoice, answerChoices, isMandatory];
}
