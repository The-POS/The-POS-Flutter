import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/customer/data/models/customer.dart';
import 'package:thepos/features/customer/data/serives/data_sources/api_customer/customer_remote_data_source.dart';
import 'package:thepos/features/customer/data/serives/data_sources/api_customer/remote_store_cutomer_error.dart';

import '../helpers/mock_client_stub.dart';
import '../invoice/helpers/shared_test_helper.dart';
import 'helper/remote_store_customer_sut.dart';
import 'helper/customer_test_helper.dart';

void main() {
  RemoteStoreCustomerSUT _makeSUT({String? token}) {
    final MockClientStub client = MockClientStub();
    final CustomerRemoteDataSource sut =
    CustomerRemoteDataSource(client, Uri.http('domain', 'path'),token);
    return RemoteStoreCustomerSUT(client, sut);
  }

  tearDown(() {
    MockClientStub.clear();
  });

  test('init does not post any data to the end point', () {
    _makeSUT();
    expect(MockClientStub.requests.isEmpty, true);
  });

  test('store post the correct data to the end point', () async {
    final RemoteStoreCustomerSUT sut = _makeSUT();

    await await tryFunction(() => sut.remoteStoreCustomer.store(anyCustomer));

    expect(MockClientStub.requests.first.body, json.encode(anyJsonCustomer));
  });

  test('store delivers error on the client error', () async {
    final RemoteStoreCustomerSUT sut = _makeSUT();

    sut.client.completeWith(anyException);

    final dynamic error =
    await tryFunction(() => sut.remoteStoreCustomer.store(anyCustomer));

    expect(error, RemoteStoreCustomerErrors.connectivity);
  });

  test('store delivers error on non 201 HTTP Response', () async {
    final RemoteStoreCustomerSUT sut = _makeSUT();
    final List<int> samples = <int>[199, 200, 300, 400, 500];
    for (final int statusCode in samples) {
      sut.client.completeWithResponse(
          MockClientStub.createResponse(statusCode, 'response'));
      final dynamic error =
      await tryFunction(() => sut.remoteStoreCustomer.store(anyCustomer));
      expect(error != null, true);
    }
  });

  test('store delivers duplicate client id error on 409 HTTP Response',
          () async {
        final RemoteStoreCustomerSUT sut = _makeSUT();
        sut.client
            .completeWithResponse(MockClientStub.createResponse(409, 'response'));
        final dynamic error =
        await tryFunction(() => sut.remoteStoreCustomer.store(anyCustomer));
        expect(error, RemoteStoreCustomerErrors.alreadyExistCustomer);
      });

  test('store delivers not found error on 404 HTTP Response', () async {
    final RemoteStoreCustomerSUT sut = _makeSUT();
    sut.client
        .completeWithResponse(MockClientStub.createResponse(404, 'response'));
    final dynamic error =
    await tryFunction(() => sut.remoteStoreCustomer.store(anyCustomer));
    expect(error, RemoteStoreCustomerErrors.notFound);
  });

  test('store delivers created customer on 201 HTTP Response', () async {
    final RemoteStoreCustomerSUT sut = _makeSUT();

    final Customer customer = anyCustomer;
    final String response = jsonEncode(customer.toJson());

    sut.client
        .completeWithResponse(MockClientStub.createResponse(201, response));

    final Customer result = await sut.remoteStoreCustomer.store(customer);
    //
    expect(result.mobile_no, customer.mobile_no);
  });

  test('store add the correct header to the end point when token is available',
          () async {
        const String token = 'token';
        final RemoteStoreCustomerSUT sut = _makeSUT(token: token);

        await await tryFunction(() => sut.remoteStoreCustomer.store(anyCustomer));

        expect(MockClientStub.requests.first.headers, <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token',
        });
      });
}