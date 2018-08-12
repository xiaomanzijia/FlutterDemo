import '../model/UserInfo.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class DataUtils {
  static final String SP_UID = "uid";

  static Future<UserInfo> saveUserInfo(Map data) async {
    if (data != null) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String name = data['name'];
      num id = data['id'];
      String gender = data['gender'];
      String location = data['location'];
      String avatar = data['avatar'];
      String email = data['email'];
      String url = data['url'];

      await sp.setInt(SP_UID, id);
      UserInfo userInfo =
          new UserInfo(gender, name, location, id, avatar, email, url);
      return userInfo;
    }
    return null;
  }


}
