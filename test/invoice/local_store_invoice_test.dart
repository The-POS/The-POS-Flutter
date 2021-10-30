import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:thepos/features/invoice/models/invoice.dart';

void main() {
  setUp(() {
    Hive.init('testPath');
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  test('retrieve delivers empty on empty cache', () async {
    final Box<Map<String, dynamic>> hiveBox = await Hive.openBox('testBox');
    final LocalStoreInvoice localStoreInvoice =
        LocalStoreInvoice(hiveBox: hiveBox);
    final List<Invoice> result = localStoreInvoice.retrieve();
    expect(result.isEmpty, true);
  });
}

class LocalStoreInvoice {
  LocalStoreInvoice({required this.hiveBox});

  final Box<Map<String, dynamic>> hiveBox;

  List<Invoice> retrieve() {
    return hiveBox.values
        .map((Map<String, dynamic> json) => Invoice.fromJson(json))
        .toList();
  }
}
