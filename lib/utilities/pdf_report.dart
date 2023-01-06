import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:wuchers_garage/utilities/models/task_model.dart';

//generate pdf file
Future<void> createPDF(
    {required BuildContext ctx, required List<TaskData> tasks}) async {
  final List<TaskData> lOfTasks = tasks;

  final pdf = pw.Document();

  PdfColor color = const PdfColor.fromInt(0xFFA13333);

  final image = (await rootBundle.load('assets/images/mechanic.png'))
      .buffer
      .asUint8List();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      build: (pw.Context context) {
        return pw.Stack(
          children: [
            pw.Column(
              children: [
                pw.Container(
                  color: color,
                  height: 150.0,
                  width: double.infinity,
                  child: pw.Stack(
                    alignment: pw.Alignment.center,
                    children: [
                      //logo
                      pw.Positioned(
                        top: 10.0,
                        child: pw.Image(
                          pw.MemoryImage(image),
                          height: 100.0,
                          width: 100.0,
                        ),
                      ),

                      pw.Positioned(
                        bottom: 5.0,
                        child: pw.Text(
                          'Wucher\'s Garage',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            color: PdfColor.fromHex('#FFFFFF'), //white
                            font: pw.Font.courierBold(),
                            fontSize: 30.0,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Padding(
                  //header
                  padding: const pw.EdgeInsets.all(
                    15.0,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Text(
                        'Title',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      pw.Text(
                        'Date',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      pw.Text(
                        'Assigned\nTo',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      pw.Text(
                        'Assigned\nBy',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.ListView(
                  children: List.generate(
                    lOfTasks.length,
                    (index) {
                      return pw.Container(
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(
                            15.0,
                          ),
                          child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                            children: [
                              pw.Text(
                                lOfTasks[index].title,
                              ),
                              pw.Text(
                                DateFormat.yMd().format(
                                  DateTime.parse(
                                    lOfTasks[index].date,
                                  ),
                                ),
                              ),
                              pw.Text(
                                lOfTasks[index].assignedTo!,
                              ),
                              pw.Text(
                                lOfTasks[index].assignedBy!,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            pw.Positioned(
              left: 0.0,
              bottom: 0.0,
              child: pw.Container(
                color: color,
                height: 100.0,
                width: 10.0,
              ),
            ),
            pw.Positioned(
              right: 0.0,
              bottom: 0.0,
              child: pw.Container(
                color: color,
                height: 100.0,
                width: 10.0,
              ),
            ),
          ],
        );
      },
    ),
  );

  final String? path = (await getExternalStorageDirectory())?.path;
  final String p = '$path/report.pdf';
  final File loc = File(p);

  await loc.writeAsBytes(await pdf.save());

  launch(path: p);
}

//launch pdf
Future<void> launch({required String path}) async {
  OpenFile.open(path);
}
