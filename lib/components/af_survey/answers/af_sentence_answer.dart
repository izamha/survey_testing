import 'package:flutter/material.dart';
import 'package:survey_testing/components/af_survey/models/af_question.dart';

class AfSentenceAnswer extends StatefulWidget {
  const AfSentenceAnswer({
    super.key,
    required this.onChange,
    required this.question,
  });

  final void Function(List<String> answers) onChange;
  final AfQuestion question;

  @override
  State<AfSentenceAnswer> createState() => _AfSentenceAnswerState();
}

class _AfSentenceAnswerState extends State<AfSentenceAnswer> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.question.answers.isNotEmpty) {
      _textEditingController.text = widget.question.answers.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: _textEditingController,
        onChanged: (value) {
          widget.onChange([_textEditingController.text]);
        },
      ),
    );
  }
}
