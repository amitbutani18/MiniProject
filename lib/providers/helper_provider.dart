import 'package:flutter/cupertino.dart';

class HelperProvider with ChangeNotifier {
  var _noticeShow = true;

  bool get noticeShow {
    return _noticeShow;
  }

  chageNoticeValue() {
    _noticeShow = false;
    notifyListeners();
  }
}
