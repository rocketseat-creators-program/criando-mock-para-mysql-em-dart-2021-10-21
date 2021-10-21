import 'package:mocktail/mocktail.dart';
import 'package:mysql1/mysql1.dart';
import 'package:test/expect.dart';

class MockMysqlResultRow extends Mock implements ResultRow {

  @override
  List<Object?>? values;

  @override
  Map<String, dynamic> fields;

  MockMysqlResultRow(this.fields);

  @override
  dynamic operator [](dynamic index) {
    if (index is int) {
      fail('Values not found');
    } else {
      var fieldName = index.toString();

      if(fields.containsKey(fieldName)){
        return fields[fieldName];
      }else {
        fail('Field $fieldName not found');
      }
    }
  }
}
