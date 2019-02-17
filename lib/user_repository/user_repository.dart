import 'package:flutter_app_bloc/api_provider.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

class UserRepository {
  final DVIApiProvider apiProvider;

  UserRepository({@required this.apiProvider});

  Future<String> login({
    @required String username,
    @required String password,
  }) async {

    var toke = await authenticate();
    if (toke == null) {
      // initiate login with server
      print("login to server");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("error");
      // attempt to sign in with retrieve details
//      throw Future.error(error)
      return authenticate();
    }

    store(username: username, password: password);
    var token = 'token';
    persistToken(token);
    return token;
  }

  Future<String> authenticate() async {
    final retrievedDetails = await retrieve();
    if (retrievedDetails.item1 != null && retrievedDetails.item2 != null) {
      print("login with saved preference");
      var token = 'token';
      persistToken(token);
      return token;
      // attempt to sign in with retrieve details
    }
    return null;
  }

  Future<void> store({
    @required String username,
    @required String password,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);
  }

  Future<Tuple2<String, String>> retrieve() async {
    var prefs = await SharedPreferences.getInstance();
    return Tuple2(prefs.getString('username'), prefs.getString('password'));
  }

  Future<void> reset() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('username', null);
    prefs.setString('password', null);
    return;
  }

  Future<bool> avaliable() async {
    var prefs = await SharedPreferences.getInstance();
    bool stayLoggedin = prefs.getBool('stayLoggedIn');
    if (stayLoggedin == null) stayLoggedin = true; //Default
    prefs.setBool('stayLoggedIn', stayLoggedin);
    return stayLoggedin;
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
