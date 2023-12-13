import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  String login = 'login';
  String googleLogin = 'googleLogin';
  String appleLogin = 'appleLogin';
  String signLogin = 'signLogin';
  String token = 'token';
  String gToken = 'gtoken';
  String aToken = 'atoken';
  String emailKey = 'email';
  String registerToken = 'rtoken';
  String changeEmailKey = 'email';
  String passwordKey = 'password';
  String name = 'name';
  String username = 'username';
  String phone = 'phone';
  String photo = 'photo';
  final String code = 'code';
  static String firstRun = 'firstRun';
  String vProfile = 'profile';
  String sizeAndWeight = 'size';
  String favourites = 'favourites';
  String pets = 'pets';
  String dateAndEvent = 'date';
  String userId = 'userId';
  // int chatId = 0;
  String intKey = 'intKey';
  static SharedPreferences? _prefs;

  Future setPPercent(String percent) async {
    return await _prefs?.setString(vProfile, percent);
  }

  String? getPPercent() {
    return _prefs?.getString(vProfile);
  }

  Future setSize(String percent) async {
    return await _prefs?.setString(sizeAndWeight, percent);
  }

  String? getSetSize() {
    return _prefs?.getString(sizeAndWeight);
  }

  Future setFavourites(String percent) async {
    return await _prefs?.setString(favourites, percent);
  }

  String? getFavourites() {
    return _prefs?.getString(favourites);
  }

  Future setPets(String percent) async {
    return await _prefs?.setString(pets, percent);
  }

  String? getPets() {
    return _prefs?.getString(pets);
  }

  Future setDateAndEvents(String percent) async {
    return await _prefs?.setString(dateAndEvent, percent);
  }

  String? getSetDateAndEvents() {
    return _prefs?.getString(dateAndEvent);
  }

  Future clearPrefs() async {
    _prefs!.clear();
  }

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future setId(String id) async {
    return await _prefs?.setString(userId, id);
  }

  String? getId() {
    return _prefs?.getString(userId);
  }

  Future setUsername(String loginUsername) async {
    return await _prefs?.setString(username, loginUsername);
  }

  Future setPassword(String loginPassword) async {
    return await _prefs?.setString(passwordKey, loginPassword);
  }

  String? getPassword() {
    return _prefs?.getString(passwordKey);
  }

  Future setGoogleToken(String googleToken) async {
    return await _prefs?.setString(gToken, googleToken);
  }

  String? getGoogleToken() {
    return _prefs?.getString(gToken);
  }

  Future setAppleToken(String googleToken) async {
    return await _prefs?.setString(aToken, googleToken);
  }

  String? getAppleToken() {
    return _prefs?.getString(aToken);
  }

  String? getUsername() {
    return _prefs?.getString(username);
  }

  Future setUserPhoto(String userPhoto) async {
    return await _prefs?.setString(photo, userPhoto);
  }

  String? getUserPhoto() {
    return _prefs?.getString(photo);
  }

  Future setName(String loginName) async {
    return await _prefs?.setString(name, loginName);
  }

  String? getName() {
    return _prefs?.getString(name);
  }

  String? getLoginToken() {
    return _prefs?.getString(token);
  }

  String? getRegisterToken(){
    return _prefs?.getString(registerToken);
  }

  Future setEmail(String email) async {
    return await _prefs?.setString(emailKey, email);
  }

  String? getChangeEmail() {
    return _prefs?.getString(changeEmailKey);
  }

  Future setChangeEmail(String email) async {
    return await _prefs?.setString(changeEmailKey, email);
  }

  Future setPhone(String phoneNO) async {
    return await _prefs?.setString(phone, phoneNO);
  }

  String? getPhone() {
    return _prefs?.getString(phone);
  }

  Future setLoginToken(String loginToken) async {
    return await _prefs?.setString(token, loginToken);
  }

  Future setRegisterToken(String resToken) async {
    return await _prefs?.setString(registerToken, resToken);
  }
  Future setLoginTrue() async {
    return await _prefs?.setBool(login, true);
  }

  bool? getLogin() {
    return _prefs?.getBool(login);
  }

  bool? getGoogleLogin() {
    return _prefs?.getBool(googleLogin);
  }

  bool? getAppleLogin() {
    return _prefs?.getBool(appleLogin);
  }

  Future setAppleTrue() async {
    return await _prefs?.setBool(appleLogin, true);
  }

  Future setAppleLoginFalse() async {
    return await _prefs?.setBool(appleLogin, false);
  }

  Future setGoogleTrue() async {
    return await _prefs?.setBool(googleLogin, true);
  }

  Future setGoogleLoginFalse() async {
    return await _prefs?.setBool(googleLogin, false);
  }

  bool? getFirstRun() {
    return _prefs?.getBool(firstRun);
  }

  bool? getSignLogin() {
    return _prefs?.getBool(signLogin);
  }

  String? getEmail() {
    return _prefs?.getString(emailKey);
  }

  static Future setFirstRunDone() async {
    return await _prefs?.setBool(firstRun, true);
  }

  Future setGoogleFalse() async {
    return await _prefs?.setBool(googleLogin, false);
  }

  Future setLoginFalse() async {
    return await _prefs?.setBool(login, false);
  }

  Future setIntValue(int value) async {
    return await _prefs?.setString(intKey, value.toString());
  }

  int? getIntValue() {
    String? stringValue = _prefs?.getString(intKey);
    return stringValue != null ? int.tryParse(stringValue) : null;
  }

}
