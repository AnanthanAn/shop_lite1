import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shoplite1/models/http_exception.dart';

class Auth with ChangeNotifier {
  String authToken;
  DateTime expireDate;
  String userId;

  bool get isAuth {
    return authToken != null; //return true if authKey is not null
  }

  String get token {
    return authToken;
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
      authToken = responseData['idToken'];
      expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      userId = responseData['localId'];
      print('User Id = $userId');
    } catch (error) {
      print('error - -- -- -- ${error.toString()}');
      throw error;
    }
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
      authToken = responseData['idToken'];
      expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      userId = responseData['localId'];
      print('User Id = $userId');
    } catch (error) {
      print('error - -- -- -- ${error.toString()}');
      throw HttpException(message: error.toString());
      throw error;
    }
  }
}
