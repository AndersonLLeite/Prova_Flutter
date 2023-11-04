import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'infostore.g.dart';

class InfoStore = _InfoStore with _$InfoStore;

abstract class _InfoStore with Store {
  _InfoStore() {
    loadInfoList();
  }

  final prefs = SharedPreferences.getInstance();
  @observable
  var _infoList = ObservableList<String>();

  get infoList => _infoList;

  @action
  addInfo(String info) {
    infoList.add(info);
    saveInfoList();
  }

  @action
  removeInfo(String info) {
    infoList.remove(info);
    saveInfoList();
  }

  @action
  updateInfo(int index, String newInfo) {
    infoList[index] = newInfo;
    saveInfoList();
  }

  Future<void> saveInfoList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('infoList', infoList);
  }

  Future<void> loadInfoList() async {
    final prefs = await SharedPreferences.getInstance();
    _infoList = prefs.getStringList('infoList')?.asObservable() ??
        ObservableList<String>();
  }
}
