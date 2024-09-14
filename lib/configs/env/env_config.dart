import 'dart:io';

import 'package:flutter/foundation.dart';

class EnvConfig {
/*   static String apiUrl = Platform.isAndroid ? 'http://10.0.2.2:3000/api'
      : 'http://localhost:3000/api'; */
/*   static String socketUrl =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000'; */

  static String apiUrl() {
    if (kIsWeb) {
      return 'https://messenger-chat-server-334d60c09c2c.herokuapp.com/api';
    } else if (Platform.isAndroid) {
      return 'https://messenger-chat-server-334d60c09c2c.herokuapp.com/api';
    } else if (Platform.isIOS) {
      return 'https://messenger-chat-server-334d60c09c2c.herokuapp.com/api';
    } else {
      return 'https://messenger-chat-server-334d60c09c2c.herokuapp.com/api';
    }
  }

  static String socketUrl() {
    if (kIsWeb) {
      return 'https://messenger-chat-server-334d60c09c2c.herokuapp.com';
    } else if (Platform.isAndroid) {
      return 'https://messenger-chat-server-334d60c09c2c.herokuapp.com';
    } else if (Platform.isIOS) {
      return 'https://messenger-chat-server-334d60c09c2c.herokuapp.com';
    } else {
      return 'https://messenger-chat-server-334d60c09c2c.herokuapp.com';
    }
  }
}
