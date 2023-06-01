import 'package:diffutil_sliverlist/diffutil_sliverlist.dart';
import 'package:flutter/material.dart';
import 'package:survey_testing/components/af_survey/models/af_question.dart';
import 'package:survey_testing/components/af_survey/utils/af_deep_copy.dart';
import 'package:survey_testing/components/af_survey/widgets/af_question_card.dart';

import '../models/af_question_result.dart';

class AfSurvey extends StatefulWidget {
  const AfSurvey({
    super.key,
    required this.initialData,
    this.builder,
    this.onNext,
    this.defaultErrorText,
  });

  /// The list of [AfQuestion] objects that dictate the flow and behaviour of the survey.
  final List<AfQuestion> initialData;

  /// Function that returns a custom widget that is to be rendered as a field, preferably [FormField]
  final Widget Function(BuildContext context, AfQuestion question,
      void Function(List<String>) update)? builder;

  /// An optional method to call with the questions answered so far.
  final void Function(List<AfQuestionResult> questionResults)? onNext;

  /// A paramater to configure the default error message to be shown when validation fails.
  final String? defaultErrorText;

  @override
  State<AfSurvey> createState() => _AfSurveyState();
}

class _AfSurveyState extends State<AfSurvey> {
  late List<AfQuestion> _surveyState;
  late Widget Function(
    BuildContext context,
    AfQuestion question,
    void Function(List<String>) update,
  ) builder;

  @override
  void initState() {
    super.initState();
    _surveyState =
        widget.initialData.map((question) => question.clone()).toList();

    if (widget.builder != null) {
      builder = widget.builder!;
    } else {
      builder = (context, model, update) => AfQuestionCard(
            key: ObjectKey(model),
            question: model,
            update: update,
            defaultErrorText: model.errorText ??
                (widget.defaultErrorText ?? "This field is mandatory*"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    var children = _buildChildren(_surveyState.cast<AfQuestion>());

    return CustomScrollView(slivers: [
      DiffUtilSliverList.fromKeyedWidgetList(
        children: children,
        insertAnimationBuilder: (context, animation, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        removeAnimationBuilder: (context, animation, child) => FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            axisAlignment: 0,
            child: child,
          ),
        ),
      ),
    ]);
  }

  List<AfQuestionResult> _mapCompletionData(List<AfQuestion> questionNodes) {
    List<AfQuestionResult> list = [];
    for (int i = 0; i < questionNodes.length; i++) {
      if (_isAnswered(questionNodes[i])) {
        var child = AfQuestionResult(
            questionText: questionNodes[i].questionText,
            answers: questionNodes[i].answers);
        list.add(child);

        for (var answer in questionNodes[i].answers) {
          if (_hasAssociatedQuestionList(questionNodes[i], answer)) {
            child.children.addAll(
                _mapCompletionData(questionNodes[i].answerChoices[answer]!));
          }
        }
      }
    }
    return list;
  }

  List<Widget> _buildChildren(List<AfQuestion> questionNodes) {
    List<Widget> list = [];
    for (int i = 0; i < questionNodes.length; i++) {
      var child = builder(context, questionNodes[i], (List<String> value) {
        questionNodes[i].answers.clear();
        questionNodes[i].answers.addAll(value);
        setState(() {});
        widget.onNext?.call(_mapCompletionData(_surveyState.cast<AfQuestion>())
            .cast<AfQuestionResult>());
      });
      list.add(child);
      if (_isAnswered(questionNodes[i]) &&
          _isNotSentenceQuestion(questionNodes[i])) {
        for (var answer in questionNodes[i].answers) {
          if (_hasAssociatedQuestionList(questionNodes[i], answer)) {
            list.addAll(
                _buildChildren(questionNodes[i].answerChoices[answer]!));
          }
        }
      }
    }
    return list;
  }

  bool _isAnswered(AfQuestion question) {
    return question.answers.isNotEmpty;
  }

  bool _isNotSentenceQuestion(AfQuestion question) {
    return question.answerChoices.isNotEmpty;
  }

  bool _hasAssociatedQuestionList(AfQuestion question, String answer) {
    return question.answerChoices[answer] != null;
  }
}
