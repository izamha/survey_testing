import 'package:flutter/material.dart';
import 'package:survey_testing/components/af_survey/models/af_question.dart';

class AfSingleChoiceAnswer extends StatefulWidget {
  const AfSingleChoiceAnswer({
    super.key,
    required this.question,
    required this.onChange,
  });

  /// The parameter that contains the data pertaining to a question
  final AfQuestion question;

  /// A callback function that must be called with the answer
  final void Function(List<String> answers) onChange;

  @override
  State<AfSingleChoiceAnswer> createState() => _AfSingleChoiceAnswerState();
}

class _AfSingleChoiceAnswerState extends State<AfSingleChoiceAnswer> {
  String? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    if (widget.question.answers.isNotEmpty) {
      _selectedAnswer = widget.question.answers.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.question.answerChoices.keys
            .map((answer) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Radio(
                          value: answer,
                          groupValue: _selectedAnswer,
                          onChanged: (value) {
                            setState(() {
                              _selectedAnswer = value as String;
                            });
                            widget.onChange([_selectedAnswer!]);
                          }),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(answer),
                      )
                    ],
                  ),
                ))
            .toList());
  }
}
