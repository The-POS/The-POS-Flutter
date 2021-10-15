import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

class MockClientStub extends MockClient {
  MockClientStub() : super(_mockClientHandler);

  static var urls = [];
  static Exception? clientException;
  static Response? clientResponse;

  static Future<Response> _mockClientHandler(http.Request request) {
    urls.add(request.url);
    if (clientException != null) {
      throw clientException!;
    } else if (clientResponse != null) {
      return Future.value(clientResponse);
    }
    return Future.value(createResponse(200, ''));
  }

  completeWith(Exception exception) {
    clientException = exception;
  }

  completeWithResponse(Response response) {
    clientResponse = response;
  }

  static Response createResponse(int statusCode, String body) =>
      Response(body, statusCode);

  static void clear() {
    urls.clear();
    clientException = null;
    clientResponse = null;
  }
}
