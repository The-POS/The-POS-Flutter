import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

class MockClientStub extends MockClient {
  MockClientStub() : super(_mockClientHandler);

  static List<http.Request> requests = <http.Request>[];
  static Exception? clientException;
  static Response? clientResponse;

  static Future<Response> _mockClientHandler(http.Request request) {
    requests.add(request);
    if (clientException != null) {
      throw clientException!;
    } else if (clientResponse != null) {
      return Future<Response>.value(clientResponse);
    }
    return Future<Response>.value(createResponse(200, ''));
  }

  void completeWith(Exception exception) {
    clientException = exception;
  }

  void completeWithResponse(Response response) {
    clientResponse = response;
  }

  static Response createResponse(int statusCode, String body) =>
      Response(body, statusCode);

  static void clear() {
    requests.clear();
    clientException = null;
    clientResponse = null;
  }
}
