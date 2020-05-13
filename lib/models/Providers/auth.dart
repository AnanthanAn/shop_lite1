import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplite1/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _authToken;
  DateTime expireDate;
  String _userId;

  bool get isAuth {
    return _userId != null; //return true if authKey is not null
  }

  String get token {
    if (_authToken != null ) {
      return _authToken;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> signUp(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAE3fUnpUUFZR61UYJ6dv260h_4YNPGDsE'; //use your own API key
    try {
      var response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      print(response.body);
      var responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        print('http error - -- -- -- ${responseData['error']['message']}');
        throw HttpException(message: responseData['error']['message']);
      }
      _authToken = responseData['idToken'];
      expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _userId = responseData['localId'];
      print('User Id = $_userId');
      final prefs = await SharedPreferences.getInstance();
      final userData =
          json.encode({'authToken': _authToken, 'userId': _userId});
      prefs.setString('userData', userData);
    } catch (error) {
      print('error - -- -- -- ${error.toString()}');
      throw error;
    }
    notifyListeners();
  }

  Future<void> logIn(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAE3fUnpUUFZR61UYJ6dv260h_4YNPGDsE'; //use your own APi key
    try {
      var response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      print(response.body);
      var responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        print('http error - -- -- -- ${responseData['error']['message']}');
        throw HttpException(message: responseData['error']['message']);
      }
      _authToken = responseData['idToken'];
      expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _userId = responseData['localId'];
      print('User Id = $_userId');
      final prefs = await SharedPreferences.getInstance();
      final userData =
          json.encode({'authToken': _authToken, 'userId': _userId});
      prefs.setString('userData', userData);
    } catch (error) {
      print('error - -- -- -- ${error.toString()}');
      throw HttpException(message: error.toString());
      throw error;
    }
    notifyListeners();
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final userData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _authToken = userData['authToken'];
    _userId = userData['userId'];
    print('User id --------- --- -- -- $_userId');
    if (_userId == null || _userId.isEmpty) {
//      notifyListeners();
      return false;
    }
    notifyListeners();
    return true;
  }

  void logOut() async {
    _authToken = null;
    expireDate = null;
    _userId = null;
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
    notifyListeners();
  }
}
