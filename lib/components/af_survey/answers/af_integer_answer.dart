import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_testing/components/af_survey/models/af_question.dart';
import 'package:survey_testing/components/af_survey/models/formats/af_integer_answer_format.dart';

class AfIntegerAnswer extends StatefulWidget {
  const AfIntegerAnswer({
    super.key,
    required this.onChange,
    required this.question,
  });

  final void Function(List<String> answers) onChange;
  final AfQuestion question;

  @override
  State<AfIntegerAnswer> createState() => _AfIntegerAnswerState();
}

class _AfIntegerAnswerState extends State<AfIntegerAnswer> {
  late final AfIntegerAnswerFormat _integerAnswerFormat;
  late final TextEditingController _controller;
  late final DateTime _startDate;

  @override
  void initState() {
    super.initState();
    // _integerAnswerFormat = IntegerAnswerFormat();
    _controller = TextEditingController();
    _startDate = DateTime.now();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          textInputAction: TextInputAction.next,
          autofocus: true,
          decoration: textFieldInputDecoration(hint: "Integer Answer Hint"),
          controller: _controller,
          onChanged: (String value) {
            // Check validation
          },
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
