import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wuchers_garage/providers/employee_provider.dart';
import 'package:wuchers_garage/providers/task_provider.dart';
import 'package:wuchers_garage/screens/assign_employees.dart';
import 'package:wuchers_garage/screens/confirm_task.dart';
import 'package:wuchers_garage/screens/employees/employee_page_navigation.dart';
import 'package:wuchers_garage/screens/login_screen.dart';
import 'package:wuchers_garage/screens/managers/manager_navigation.dart';
import 'package:wuchers_garage/screens/new_task.dart';
import 'package:wuchers_garage/screens/view_staff.dart';
import 'package:wuchers_garage/screens/wucher/wucher_page_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //portrait orientation
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EmployeeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),
      ],
      builder: (context, _) {
        return MaterialApp(
          title: 'Wucher\'s Garage',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: LoginScreen.login,
          routes: {
            LoginScreen.login: (context) => const LoginScreen(),
            WucherPageNavigation.wucherNav: (context) =>
                const WucherPageNavigation(),
            ManagerPageNavigation.managerNav: (context) =>
                const ManagerPageNavigation(),
            EmployeePageNavigation.employeeNav: (context) =>
                const EmployeePageNavigation(),
            ConfirmTaskScreen.confirm: (context) => ConfirmTaskScreen(),
            NewTaskScreen.newTask: (context) => const NewTaskScreen(),
            AssignEmployeesScreen.assignEmployees: (context) =>
                AssignEmployeesScreen(),
            ViewStaffScreen.viewStaff: (context) => const ViewStaffScreen(),
          },
        );
      },
    );
  }
}
