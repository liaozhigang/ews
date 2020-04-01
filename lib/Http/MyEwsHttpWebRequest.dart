import 'dart:async';
import 'dart:convert';

import 'CookieContainer.dart' as cookie;
import 'ICredentials.dart';
import 'IWebProxy.dart';
import 'WebHeaderCollection.dart';
import 'X509CertificateCollection.dart';
import '../Interfaces/IEwsHttpWebResponse.dart';

import '../Interfaces/IEwsHttpWebRequest.dart';

import 'package:http/http.dart' as http;

import 'MyEwsHttpWebResponse.dart';
import 'MyStreamedRequest.dart';
import 'WebCredentials.dart';
import 'WebException.dart';
import 'WebExceptionStatus.dart';

class MyEwsHttpWebRequest implements IEwsHttpWebRequest {
  @override
  String Accept;

  @override
  bool AllowAutoRedirect;

  @override
  X509CertificateCollection ClientCertificates;

  @override
  String ConnectionGroupName;

  @override
  String ContentType;

  @override
  cookie.CookieContainer CookieContainer;

  @override
  ICredentials Credentials;

  @override
  WebHeaderCollection Headers = WebHeaderCollection();

  @override
  bool KeepAlive;

  @override
  String Method;

  @override
  bool PreAuthenticate;

  @override
  IWebProxy Proxy;

  @override
  Uri RequestUri;

  @override
  int Timeout;

  @override
  bool UseDefaultCredentials;

  @override
  String UserAgent;

  @override
  void Abort() {
    // TODO: implement Abort
  }

  MyStreamedRequest _request;
  http.Client _client;

  @override
  Future<StreamConsumer<List<int>>> GetRequestStream() async {
    return _InternalGetRequest();
  }

  Future<StreamConsumer<List<int>>> _InternalGetRequest() async {
    if (_request == null) {
      _client = http.Client();

      _request = MyStreamedRequest(Method, RequestUri);

      _client.send(_request);

      _request.followRedirects = AllowAutoRedirect;

      if (Credentials != null) {
        final user = (Credentials as WebCredentials).user;
        String password = (Credentials as WebCredentials).pwd;
        String auth = 'Basic ' + base64Encode(utf8.encode('$user:$password'));
        _request.headers["Authorization"] = auth;
      }

      if (this.Accept != null) {
        _request.headers["Accept"] = this.Accept;
      }
      if (this.ContentType != null) {
        _request.headers["Content-Type"] = this.ContentType;
      }

    }

    return _request.controller;
  }

  @override
  Future<IEwsHttpWebResponse> GetResponse() async {
    if (_request == null) {
      await _InternalGetRequest();
    }


    var response = await _client.send(_request);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw new WebException(
          WebExceptionStatus.ProtocolError, null, null);
    }
    _client.close();
    return MyEwsHttpWebResponse(this, response);
  }

}