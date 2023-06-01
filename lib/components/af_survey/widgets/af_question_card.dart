import 'package:flutter/material.dart';
import 'package:survey_testing/components/af_survey/models/af_question.dart';
import 'package:survey_testing/components/af_survey/widgets/af_answer_choice_widget.dart';
import 'package:survey_testing/components/af_survey/widgets/af_survey_form_field.dart';

class AfQuestionCard extends StatelessWidget {
  const AfQuestionCard({
    super.key,
    required this.question,
    required this.update,
    this.onSaved,
    this.autovalidateMode,
    required this.defaultErrorText,
    this.validator,
  });

  /// The parameter that contains the data partaining to a question.
  final AfQuestion question;

  /// A callback function that must be called with answers to rebuild the survey elements.
  final void Function(List<String>) update;

  /// An optional method to call with the final value when the form is saved via FormState.save
  final FormFieldSetter<List<String>>? onSaved;

  /// An optional method that validates an input. Returns an error string to display if the input is invalid, or null otherwise.
  final FormFieldValidator<List<String>>? validator;

  /// Used to configure the auto validation of FormField and Form widgets
  final AutovalidateMode? autovalidateMode;

  /// Used to configure the default errorText for the validator.
  final String defaultErrorText;

  @override
  Widget build(BuildContext context) {
    return AfSurveyFormField(
      question: question,
      defaultErrorText: defaultErrorText,
      onSaved: onSaved,
      validator: validator,
      builder: (FormFieldState<List<String>> state) {
        return Container(
          margin: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 24,
                    right: 20,
                    left: 20,
                    bottom: 6,
                  ),
                  child: RichText(
                    text: TextSpan(
                        text: question.questionText,
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: question.isMandatory
                            ? [
                                const TextSpan(
                                  text: "*",
                                  style: TextStyle(color: Colors.red),
                                )
                              ]
                            : null),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 4,
                    right: 20,
                    top: 6,
                    bottom: 6,
                  ),
                  child: AfAnswerChoiceWidget(
                      question: question,
                      onChange: (value) {
                        state.didChange(value);
                        update(value);
                      }),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
