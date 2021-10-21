import 'package:mocktail/mocktail.dart';
import 'package:mysql1/mysql1.dart';

import 'mock_mysql_result_row.dart';

class MockMysqlResults extends Mock implements Results {
  final List<ResultRow> _rows = [];

  @override
  Iterator<ResultRow> get iterator => _rows.iterator;

  @override
  bool get isEmpty => !iterator.moveNext();

  @override
  ResultRow get first {
    final it = iterator;
    if (!it.moveNext()) {
      throw Exception();
    }
    return it.current;
  }

  MockMysqlResults(List<Map<String, dynamic>> resultado) {
    var resultRows = resultado.map((results) => MockMysqlResultRow(results)).toList();
    _rows.addAll(resultRows);
  }
}
