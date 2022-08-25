import 'dart:async';

class Bloc {
  final StreamController _myController1 = StreamController<bool>();
  final StreamController _myController2 = StreamController<bool>();
  // String? toCheck;

  get changed => _myController1.stream;
  get isLoading => _myController2.stream;

  void compare(String v, String c) {
    // toCheck = c;
    if (v.length < c.length || v.length > c.length) {
      _myController1.sink.add(false);
    } else {
      _myController1.sink.add(c == v);
    }
  }

  void setLoading(bool v) => _myController2.sink.add(v);

  void dispose() => _myController1.close();
  void loadDispose() => _myController2.close();

  void disposeAll() {
    dispose();
    loadDispose();
  }
}
