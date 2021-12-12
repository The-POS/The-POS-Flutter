import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/invoice.dart';
import '../store_invoice.dart';
import 'remote_store_invoice_error.dart';

class RemoteStoreInvoice extends StoreInvoice {
  RemoteStoreInvoice(this._client, this._url, this._token);

  final http.Client _client;
  final Uri _url;
  final String? _token;

  @override
  Future<Invoice> store(Invoice invoice) async {
    final Map<String, String> headers = _buildRequestHeader();
    try {
      final http.Response response = await _client.post(
        _url,
        body: json.encode(invoice.toJson()),
        headers: headers,
      );
      if (response.statusCode == 201) {
        return _tryParse(response.body);
      } else if (response.statusCode == 404) {
        return Future<Invoice>.error(RemoteStoreInvoiceErrors.notFound);
      } else if (response.statusCode == 409) {
        return Future<Invoice>.error(
            RemoteStoreInvoiceErrors.duplicateClientId);
      } else {
        return Future<Invoice>.error(RemoteStoreInvoiceErrors.invalidData);
      }
    } catch (error) {
      return Future<Invoice>.error(RemoteStoreInvoiceErrors.connectivity);
    }
  }

  Map<String, String> _buildRequestHeader() {
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  Future<Invoice> _tryParse(String body) {
    try {
      return Future<Invoice>.value(Invoice.fromJson(jsonDecode(body)));
    } catch (error) {
      return Future<Invoice>.error(RemoteStoreInvoiceErrors.invalidData);
    }
  }
}
