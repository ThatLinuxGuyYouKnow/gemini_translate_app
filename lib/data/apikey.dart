import 'package:get_storage/get_storage.dart';

class Apikey {
  final box = GetStorage();
  get() {
    return box.read('apiKey') ?? "";
  }

  store({required String apiKey}) {
    box.write('apiKey', apiKey);
  }
}
