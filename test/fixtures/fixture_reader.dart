import 'dart:io';

String Fixture(String name) => File('test/fixtures/$name').readAsStringSync();
