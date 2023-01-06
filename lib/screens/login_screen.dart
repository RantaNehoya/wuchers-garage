import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:wuchers_garage/screens/employees/employee_page_navigation.dart';
import 'package:wuchers_garage/screens/managers/manager_navigation.dart';
import 'package:wuchers_garage/screens/wucher/wucher_page_navigation.dart';
import 'package:wuchers_garage/widgets/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const login = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List managers = [];

  Duration get loginTime => const Duration(
        milliseconds: 2250,
      );

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _staffCollection = FirebaseFirestore.instance.collection('staff');

  String pushHomepage() {
    const _wucherUID = 'zXs0A1f7GjXNdoZg0sVBK0blobF2';

    if (FirebaseAuth.instance.currentUser!.uid == _wucherUID) {
      return WucherPageNavigation.wucherNav;
    }

    if (managers.contains(FirebaseAuth.instance.currentUser!.uid)) {
      return ManagerPageNavigation.managerNav;
    }

    return EmployeePageNavigation.employeeNav;
  }

  //user auth sign in
  Future<String?> _authUser(LoginData data) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );
    } on FirebaseAuthException catch (e) {
      return Future.delayed(loginTime).then((_) {
        if (e.code == 'user-not-found') {
          return 'User does not exist';
        }
        if (e.code == 'wrong-password') {
          return 'Password does not match';
        }
        return null;
      });
    }
    return null;
  }

  //recover password
  Future<String?> _recoverPassword(String name) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: name,
      );
    } on FirebaseAuthException catch (e) {
      return Future.delayed(loginTime).then((_) {
        if (e.code == 'user-not-found') {
          return 'User does not exist';
        }
        return null;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: _staffCollection.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return kProgressIndicator;
            }

            if (snapshot.hasError) {
              return kErrorMessage;
            }

            if (!snapshot.hasData) {
              return kNoEmployees;
            }

            for (var doc in snapshot.data!.docs) {
              if (doc['isManager'] == true) {
                managers.add(doc['uid']);
              }
            }

            return FlutterLogin(
              title: 'Wucher\'s\nGarage',
              logo: 'assets/images/mechanic.png',
              navigateBackAfterRecovery: true,

              messages: LoginMessages(
                recoverPasswordDescription:
                    'We will send an email to this email address',
                recoverPasswordSuccess: 'Email successfully sent',
              ),

              theme: LoginTheme(
                primaryColor: Theme.of(context).primaryColor,
                pageColorLight: Theme.of(context).primaryColor,
                pageColorDark: Theme.of(context).primaryColorDark,
                titleStyle: const TextStyle(
                  fontFamily: 'Bungee',
                ),
              ),

              //login
              onLogin: _authUser,

              //sign up
              onSignup: (LoginData data) => null,

              onSubmitAnimationCompleted: () {
                Navigator.of(context).pushReplacementNamed(
                  pushHomepage(),
                );
              },
              onRecoverPassword: _recoverPassword,
            );
          },
        ),
      ),
    );
  }
}
