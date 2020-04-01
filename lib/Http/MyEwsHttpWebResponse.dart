import 'dart:io';

import 'package:http/http.dart';

import '../Exceptions/NotImplementedException.dart';
import '../Http/WebHeaderCollection.dart';
import '../Interfaces/IEwsHttpWebResponse.dart';
import 'MyEwsHttpWebRequest.dart';

class MyEwsHttpWebResponse implements IEwsHttpWebResponse {
  MyEwsHttpWebRequest request;
  StreamedResponse httpClientResponse;

  MyEwsHttpWebResponse(this.request, this.httpClientResponse);

  @override
  void Close() {
//    throw NotImplementedException("Close");
  }

  @override
  String get ContentEncoding =>
      this
          .httpClientResponse
          .headers[HttpHeaders.contentEncodingHeader] ?? "";

  @override
  String get ContentType =>
      this.httpClientResponse.headers["content-Type"] ?? "";

  @override
  Dispose() {
    throw NotImplementedException("Dispose");
    return null;
  }

  @override
  Stream<List<int>> GetResponseStream() {
    return this.httpClientResponse.stream;
  }

  @override
  WebHeaderCollection get Headers {
    final headers = WebHeaderCollection();
    this.httpClientResponse.headers.forEach((header, value) {
      headers[header] = value;
    });
    return headers;
  }

  @override
  Uri get ResponseUri => throw NotImplementedException("ResponseUri");

  @override
  int get StatusCode => httpClientResponse.statusCode;

  @override
  String get StatusDescription => httpClientResponse.reasonPhrase;
}
