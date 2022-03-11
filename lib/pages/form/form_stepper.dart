import 'package:digital_card_app/pages/form/form_step.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:math';
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    
    final primaryColor = Theme.of(context).primaryColor;
    final steps = getSteps(primaryColor: primaryColor);
    final stepBody = steps[_index].content as FormStepBody;
    final int length = steps.length;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _index == 0 ? Navigator.pop(context) : previous(length);
            },
            icon: const Icon(Icons.navigate_before, size: 36)),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: primaryColor,
          ),
        ),
        child: Stepper(
          onStepTapped: (d) {
            print('tapped');
          },
          type: StepperType.horizontal,
          steps: steps,
          onStepContinue: _index == (length - 1)
              ? null
              : () => next(stepBody.formKey, length),
          onStepCancel: _index == 0 ? null : () => previous(length),
          currentStep: _index,
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Align(
              alignment: Alignment.topRight,
              child: renderButton(
                primaryColor: primaryColor,
                onStepContinue: details.onStepContinue,
              ),
            );
          },
        ),
      ),
    );
  }

  void next(final GlobalKey<FormState> formKey, int length) {
    // Validate Form
    if (formKey.currentState!.validate()) {
      // Go to the next step
      final int next = _index + 1;
      if (next < length) {
        setState(() => _index++);
      }
    }
  }

  void previous(final int length) {
    // Go to the previous step
    final int previous = _index - 1;
    if (previous >= 0) {
      setState(() => _index--);
    }
  }

  FloatingActionButton renderButton({
    required Color primaryColor,
    required dynamic Function()? onStepContinue,
  }) {
    return FloatingActionButton(
      onPressed: onStepContinue,
      child: const Icon(
        Icons.navigate_next,
        size: 40,
      ),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 6.0,
    );
  }

  StepState handleStepState(int i) {
    return _index > i ? StepState.complete : StepState.indexed;
  }

  List<Step> getSteps({required Color primaryColor}) {
    return [
      Step(
        state: handleStepState(0),
        isActive: _index >= 0,
        title: const Text('Name'),
        content: FormStepBody(
          header: 'What\'s your name?',
          fields: [
            StepFieldData(label: 'Enter your first name'),
            StepFieldData(label: 'Enter your last name'),
          ],
          formKey: GlobalKey(),
        ),
      ),
      Step(
        state: handleStepState(1),
        isActive: _index >= 1,
        title: const Text('Contact'),
        content: FormStepBody(
          header: 'And you contact information?',
          fields: [
            StepFieldData(
                label: 'Enter your email',
                fillHint: AutofillHints.email,
                validator: (text) {
                  return null;
                }),
            StepFieldData(label: 'Enter your phone number')
          ],
          // topValidator: (text) {
          //   if (!EmailValidator.validate(text!)) {
          //     return 'Enter a valid email address';
          //   } else {
          //     return null;
          //   }
          // },
          //    bottomLabelText: 'Enter your phone number',
          formKey: GlobalKey(),
        ),
      ),
      Step(
        state: handleStepState(2),
        isActive: _index >= 2,
        title: const Text('Password'),
        content: FormStepBody(
          header: 'Create a password',
          formKey: GlobalKey(),
          fields: [
            StepFieldData(label: 'Enter your password'),
            StepFieldData(label: 'Verify your password'),
          ],
        ),
      ),
    ];
  }
}
