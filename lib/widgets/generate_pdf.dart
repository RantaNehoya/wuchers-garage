import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wuchers_garage/utilities/pdf_report.dart';
import 'package:wuchers_garage/providers/task_provider.dart';

class GeneratePDF extends StatelessWidget {
  const GeneratePDF({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    return GestureDetector(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 8.0,
          ),
          child: Text(
            'Generate report',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: mediaQuery.textScaleFactor * 15.0,
            ),
          ),
        ),
      ),
      onTap: () async {
        createPDF(
          ctx: context,
          tasks: taskProvider.getTaskListData,
        );
      },
    );
  }
}
