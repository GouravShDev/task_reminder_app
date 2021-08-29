import 'package:floor/floor.dart';

class BoolConverter extends TypeConverter<bool, int> {
  @override
  bool decode(int databaseValue) {
    return databaseValue == 1;
  }

  @override
  int encode(bool value) {
    return value ? 1 : 0;
  }
}
