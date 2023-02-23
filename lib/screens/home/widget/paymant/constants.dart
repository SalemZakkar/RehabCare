import 'package:hyperpay/hyperpay.dart';

class TestConfig implements HyperpayConfig {
  @override
  String? creditcardEntityID = '8ac7a4ca7843f17d017844c7623a0673';
  @override
  String? madaEntityID = '';
  @override
  Uri checkoutEndpoint = _checkoutEndpoint;
  @override
  Uri statusEndpoint = _statusEndpoint;
  @override
  PaymentMode paymentMode = PaymentMode.test;
  @override
  String? applePayEntityID;
}

class LiveConfig implements HyperpayConfig {
  @override
  String? creditcardEntityID = '';
  @override
  String? madaEntityID = '';
  @override
  Uri checkoutEndpoint = _checkoutEndpoint;
  @override
  Uri statusEndpoint = _statusEndpoint;
  @override
  PaymentMode paymentMode = PaymentMode.live;

  @override
  String? applePayEntityID;
}

// Setup using your own endpoints.
// https://wordpresshyperpay.docs.oppwa.com/tutorials/mobile-sdk/integration/server.

String _host = 'aboutcare.net';

Uri _checkoutEndpoint = Uri(
  scheme: 'https',
  host: _host,
  path: '/APIs/payment'
);

Uri _statusEndpoint = Uri(
  scheme: 'https',
  host: _host,
  path: '',
);
