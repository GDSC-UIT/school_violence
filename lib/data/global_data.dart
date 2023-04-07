class GlobalData {
  static GlobalData? _instance;

  GlobalData._initInstance();

  static GlobalData getIns() {
    _instance ??= GlobalData._initInstance();
    return _instance!;
  }
}
