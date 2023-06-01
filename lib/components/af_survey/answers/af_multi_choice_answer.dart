import 'package:flutter/material.dart';
import 'package:survey_testing/components/af_survey/models/af_question.dart';

class AfMultipleChoiceAnswer extends StatefulWidget {
  const AfMultipleChoiceAnswer({
    super.key,
    required this.question,
    required this.onChange,
  });

  final AfQuestion question;
  final void Function(List<String> answers) onChange;

  @override
  State<AfMultipleChoiceAnswer> createState() => _AfMultipleChoiceAnswerState();
}

class _AfMultipleChoiceAnswerState extends State<AfMultipleChoiceAnswer> {
  late List<String> _answers;

  @override
  void initState() {
    super.initState();
    _answers = [];
    _answers.addAll(widget.question.answers);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.question.answerChoices.keys
            .map(
              (answer) => Row(
                children: [
                  Checkbox(
                      value: _answers.contains(answer),
                      onChanged: (value) {
                        if (value == true) {
                          _answers.add(answer);
                        } else {
                          _answers.remove(answer);
                        }
                        widget.onChange(_answers);
                        setState(() {});
                      }),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(answer),
                  )
                ],
              ),
            )
            .toList());
  }
}
