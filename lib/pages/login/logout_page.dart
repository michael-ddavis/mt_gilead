import 'package:flutter/material.dart';
import 'package:mt_gilead/models/state.dart';
import 'package:mt_gilead/pages/login/signin_page.dart';
import 'package:mt_gilead/utils/Palatte.dart';
import 'package:mt_gilead/utils/loading.dart';
import 'package:mt_gilead/utils/state_widget.dart';

class LogoutPage extends StatefulWidget {
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  StateModel appState;
  bool _loadingVisible = false;
  @override
  void initState() {
    super.initState();
  }
  
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    if (!appState.isLoading &&
        (appState.firebaseUserAuth == null ||
            appState.user == null ||
            appState.settings == null)) {
      return SignInScreen();
    } else {
      if (appState.isLoading) {
        _loadingVisible = true;
      } else {
        _loadingVisible = false;
      }
      final logo = Hero(
        tag: 'hero',
        child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 60.0,
            child: ClipOval(
              child: Image.asset(
                'assets/images/logo.jpg',
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
              ),
            )),
      );
      
      final signOutButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            StateWidget.of(context).logOutUser();
          },
          padding: EdgeInsets.all(12),
          color: Palatte.primaryColor,
          child: Text('SIGN OUT', style: TextStyle(color: Colors.white)),
        ),
      );
      
      final forgotLabel = FlatButton(
        child: Text(
          'Forgot password?',
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/forgot-password');
        },
      );
      
      final signUpLabel = FlatButton(
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/signup');
        },
      );
      
      final signInLabel = FlatButton(
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/signin');
        },
      );

      final userId = appState?.firebaseUserAuth?.uid ?? '';
      final email = appState?.firebaseUserAuth?.email ?? '';
      final firstName = appState?.user?.firstName ?? '';
      final lastName = appState?.user?.lastName ?? '';
      final settingsId = appState?.settings?.settingsId ?? '';
      final userIdLabel = Text('App Id: ');
      final emailLabel = Text('Email: ');
      final firstNameLabel = Text('First Name: ');
      final lastNameLabel = Text('Last Name: ');
      final settingsIdLabel = Text('SetttingsId: ');
      
      return Scaffold(
        backgroundColor: Colors.white,
        body: LoadingScreen(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      logo,
                      SizedBox(height: 48.0),
                      userIdLabel,
                      Text(userId,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.0),
                      emailLabel,
                      Text(email,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.0),
                      firstNameLabel,
                      Text(firstName,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.0),
                      lastNameLabel,
                      Text(lastName,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.0),
                      settingsIdLabel,
                      Text(settingsId,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.0),
                      signOutButton,
                      signInLabel,
                      signUpLabel,
                      forgotLabel                    ],
                  ),
                ),
              ),
            ),
            inAsyncCall: _loadingVisible),
      );
    }
  }
}