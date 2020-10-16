import 'package:shared_preferences/shared_preferences.dart';
import 'package:teronmobile/Utility/HttpManager.dart';
import 'package:teronmobile/model/KullaniciSessionModel.dart';

class LoginInterface {
  HttpManager getHttpManager() {}
  KullaniciSessionModel getKullaniciSession() {}
  SharedPreferences getPrefs() {}
}
