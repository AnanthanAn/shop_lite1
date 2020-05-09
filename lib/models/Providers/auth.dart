
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier{

  Future<void> signUp(String email, String password) async{
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAE3fUnpUUFZR61UYJ6dv260h_4YNPGDsE';
    var response = await http.post(url,body: json.encode({
      'email' : email,
      'password' : password,
      'returnSecureToken' : true
    }));
    print(response.body);
  }
}