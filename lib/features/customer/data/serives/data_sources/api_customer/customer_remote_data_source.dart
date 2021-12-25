import 'dart:convert';

import 'package:thepos/features/customer/data/models/Customers.dart';
import 'package:thepos/features/customer/data/models/customer.dart';
import 'package:http/http.dart' as http;
import 'package:thepos/features/customer/data/serives/forbiden_operation.dart';
import 'package:thepos/features/customer/data/serives/data_sources/api_customer/remote_store_cutomer_error.dart';
import 'package:thepos/features/customer/data/serives/data_sources/remote_customer.dart';

class CustomerRemoteDataSource extends RemoteCustomer {

  CustomerRemoteDataSource(this._client, this._url ,this._token);
  final http.Client _client;
  final _url ;
  final String? _token;

  @override
  Future<Customer> store(Customer customer) async {
    try {
      final Map<String, String> headers = _buildHeader();
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
            RemoteStoreCustomerErrors.alreadyExistCustomer);
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
      return Future<Customer>.error(ForbiddenOperation.fromJson(jsonDecode(body)));
    } catch (error) {
      return Future<Customer>.error(RemoteStoreCustomerErrors.invalidData);
    }
  }

  @override
  Future<List<Customer>> load() async{
    try {

      final Map<String, String> headers =_buildHeader();

      final  response = await _client.get(_url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        return _getCustomerTryParse(response.body);
      } else if (response.statusCode == 403) {
        return _getCustomerTryParseError(response.body);
      } else {
        return Future<List<Customer>>.error(RemoteStoreCustomerErrors.notFound);
      }
    } catch (error) {

      return Future<List<Customer>>.error(RemoteStoreCustomerErrors.connectivity);
    }
  }

  Future<List<Customer>> _getCustomerTryParseError(String body) {
    try {
      return Future<List<Customer>>.error(ForbiddenOperation.fromJson(jsonDecode(body)));
    } catch (error) {
      return Future<List<Customer>>.error(RemoteStoreCustomerErrors.invalidData);
    }
  }

  Future<List<Customer>> _getCustomerTryParse(body) {
    try {
      return Future.value(Customers.fromJson(jsonDecode(body)).data);
    } catch (error) {
      return Future.error(RemoteStoreCustomerErrors.invalidData);
    }
  }

  Map<String, String> _buildHeader() {
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }
}