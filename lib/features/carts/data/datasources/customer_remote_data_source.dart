import 'dart:convert';

import 'package:thepos/features/carts/data/datasources/remote_store_cutomer_error.dart';
import 'package:thepos/features/carts/data/datasources/store_customer.dart';
import 'package:thepos/features/carts/data/models/customer.dart';
import 'package:http/http.dart' as http;
import 'package:thepos/features/carts/data/models/forbiden_operation.dart';

class CustomerRemoteDataSource extends StoreCustomer {

  CustomerRemoteDataSource(this._client, this._url ,this._token);
  final http.Client _client;
  final _url ;
  final String? _token;

  @override
  Future<Customer> store(Customer customer) async {
    try {
      final Map<String, String> headers = <String, String>{
        'Content-Type': 'application/json'
      };
      if (_token != null) {
        headers['Authorization'] = 'Bearer $_token';
      }
      final http.Response response = await _client.post(
        _url,
        body: json.encode(customer.toJson()),
        headers: headers,
      );

      if (response.statusCode == 201) {
        return _tryParse(response.body);
      } else if (response.statusCode == 401) {
        return _tryParseError(response.body);
      } else if (response.statusCode == 409) {
        return Future<Customer>.error(
            RemoteStoreCustomerErrors.aleadyExistCustomer);
      } else {
        return Future<Customer>.error(RemoteStoreCustomerErrors.notFound);
      }
    } catch (error) {

      return Future<Customer>.error(RemoteStoreCustomerErrors.connectivity);
    }
  }
  Future<Customer> _tryParse(String body) {
    try {
      return Future<Customer>.value(Customer.fromJson(jsonDecode(body)));
    } catch (error) {
      return Future<Customer>.error(RemoteStoreCustomerErrors.invalidData);
    }
  }

  Future<Customer> _tryParseError(String body) {
    try {
      return Future<Customer>.error(forbidenOperation.fromJson(jsonDecode(body)));
    } catch (error) {
      return Future<Customer>.error(RemoteStoreCustomerErrors.invalidData);
    }
  }

}