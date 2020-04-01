import 'package:ews/Core/ExchangeServiceBase.dart';
import 'package:ews/Http/EwsHttpWebExceptionResponse.dart';
import 'package:ews/Http/IEwsHttpWebRequestFactory.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';

import 'MyEwsHttpWebRequest.dart';

class EwsHttpWebRequestFactory implements IEwsHttpWebRequestFactory {
  @override
  IEwsHttpWebRequest CreateRequest() {
    return MyEwsHttpWebRequest();
  }

  @override
  IEwsHttpWebRequest CreateRequestWithExchangeServiceAndUrl(
      ExchangeServiceBase exchangeService, Uri url) {
    return MyEwsHttpWebRequest()
      ..Credentials = exchangeService.Credentials
      ..RequestUri = url;
  }

  @override
  IEwsHttpWebRequest CreateRequestWithUrl(Uri url) {
    return MyEwsHttpWebRequest()..RequestUri = url;
  }

  @override
  IEwsHttpWebResponse CreateExceptionResponse(WebException e) {
    return new EwsHttpWebExceptionResponse(e);
  }
}
