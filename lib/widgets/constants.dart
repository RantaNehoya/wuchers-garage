import 'package:flutter/material.dart';

Center kProgressIndicator = const Center(
  child: CircularProgressIndicator(),
);

Center kErrorMessage = const Center(
  child: Text('An error occurred'),
);

Center kNoEmployees = const Center(
  child: Text('No Employees'),
);

Center kDateNow = Center(
  child: Column(
    children: [
      const SizedBox(
        height: 10.0,
      ),
      Text(
        'Today ${[
          'JAN',
          'FEB',
          'MAR',
          'APR',
          'MAY',
          'JUN',
          'JUL',
          'AUG',
          'SEPT',
          'OCT',
          'NOV',
          'DEC'
        ][DateTime
            .now()
            .month - 1]}, ${DateTime
            .now()
            .day}/${DateTime
            .now()
            .year}',
        style: const TextStyle(fontSize: 18, color: Colors.grey,),),
    ],
  ),
);

Padding kDivider = const Padding(
  padding: EdgeInsets.symmetric(
    vertical: 8.0,
  ),
  child: Divider(
    thickness: 1.0,
  ),
);
