import 'dart:async';
import 'package:breez/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:breez/bloc/account/account_bloc.dart';
import 'package:breez/bloc/invoice/invoice_model.dart';
import 'package:breez/widgets/payment_request_dialog.dart' as paymentRequest;

class InvoiceNotificationsHandler {
  final BuildContext _context;
  final AccountBloc _accountBloc;
  final Stream<PaymentRequestModel> _receivedInvoicesStream;

  ModalRoute _loaderRoute;
  bool _handlingRequest = false;

  InvoiceNotificationsHandler(
      this._context, this._accountBloc, this._receivedInvoicesStream) {
    _listenPaymentRequests();
  }

  _listenPaymentRequests() {
    _accountBloc.accountStream.where((acc) => acc.active).first.then((acc) {
      // show payment request dialog for decoded requests
      _receivedInvoicesStream
          .where((payreq) => payreq != null && !_handlingRequest)
          .listen((payreq) {

        if (!payreq.loaded) {
          _setLoading(true);
          return;
        }

        _setLoading(false);
        _handlingRequest = true;

        showDialog(
            context: _context,
            barrierDismissible: false,
            builder: (_) => paymentRequest.PaymentRequestDialog(
                        _context, _accountBloc, payreq))
            .whenComplete(() => _handlingRequest = false);
      }).onError((error) {
        _setLoading(false);
        _handlingRequest = false;
      });
    });
  }

  _setLoading(bool visible) {
    if (visible && _loaderRoute == null) {
      _loaderRoute = createLoaderRoute(_context);
      Navigator.of(_context).push(_loaderRoute);
      return;
    }

    if (!visible && _loaderRoute != null) {
      Navigator.removeRoute(_context, _loaderRoute);
      _loaderRoute = null;
    }
  }

}
