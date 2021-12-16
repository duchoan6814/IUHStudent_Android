import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iuh_student/config/color_config.dart';
import 'package:iuh_student/screens/regist_object_screen/step_1_subject.dart';

class RegisterObjectScreen extends StatefulWidget {
  const RegisterObjectScreen({Key? key}) : super(key: key);

  @override
  State<RegisterObjectScreen> createState() => _RegisterObjectScreenState();
}

class _RegisterObjectScreenState extends State<RegisterObjectScreen> {
  late int currentStep;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentStep = 0;
  }

  @override
  Widget build(BuildContext context) {

    List<Step> steps = [
      Step(
        title: const Text("Môn Học"),
        content: StepOne(),
        isActive: currentStep >= 0
      ),
      Step(
        title: const Text("Học Phần"),
        content: Container(),
        isActive: currentStep >= 1
      ),
      Step(
        title: Text("Hoàn Thành"),
        content: Container(),
        isActive: currentStep >= 2
      ),
    ];

    return Container(
      height: MediaQuery.of(context).size.height,
      child: Stepper(
        type: StepperType.horizontal,
        steps: steps,
        currentStep: currentStep,
        onStepTapped: (step) {
         setState(() {
           currentStep = step;
         });
        },
        controlsBuilder: (context, {onStepCancel, onStepContinue}) {
          return Row(
            children: [
              Container(
                child: null,
              ),
              Container(
                child: null,
              ),
            ],
          );
        },
      ),
    );

  }
}
