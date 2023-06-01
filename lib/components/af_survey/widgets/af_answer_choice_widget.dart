import 'package:flutter/material.dart';
import 'package:survey_testing/components/af_survey/answers/af_sentence_answer.dart';
import 'package:survey_testing/components/af_survey/answers/af_single_choice_answer.dart';
import 'package:survey_testing/components/af_survey/models/af_question.dart';

import '../answers/af_multi_choice_answer.dart';

class AfAnswerChoiceWidget extends StatefulWidget {
  const AfAnswerChoiceWidget({
    super.key,
    required this.question,
    required this.onChange,
  });

  final AfQuestion question;
  final void Function(List<String> answers) onChange;

  @override
  State<AfAnswerChoiceWidget> createState() => _AfAnswerChoiceWidgetState();
}

class _AfAnswerChoiceWidgetState extends State<AfAnswerChoiceWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.question.answerChoices.isNotEmpty) {
      if (widget.question.singleChoice) {
        return AfSingleChoiceAnswer(
            onChange: widget.onChange, question: widget.question);
      } else {
        return AfMultipleChoiceAnswer(
            onChange: widget.onChange, question: widget.question);
      }
    } else {
      return AfSentenceAnswer(
        key: ObjectKey(widget.question),
        onChange: widget.onChange,
        question: widget.question,
      );
    }
  }
}
