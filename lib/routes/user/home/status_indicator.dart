import 'package:breez/bloc/account/account_model.dart';
import 'package:flutter/material.dart';
import 'package:breez/theme_data.dart' as theme;

class StatusIndicator extends StatelessWidget {
  final AccountModel _accountModel;

  StatusIndicator(this._accountModel);

  @override
  Widget build(BuildContext context) {
    if (_accountModel?.readyForPayments == true || _accountModel?.processingConnection == true) {
      return Container();
    }

    return SizedBox(
      child: createStatusIndicator(),
      height: 2.0,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget createStatusIndicator() {
    double value;
    if (_accountModel.isInitialBootstrap && _accountModel.bootstrapProgress < 1) {
      return LinearProgressIndicator(        
        backgroundColor: Colors.white,
          valueColor:
              AlwaysStoppedAnimation<Color>(theme.BreezColors.blue[200]),
          value: _accountModel.bootstrapProgress);
    }

    return LinearProgressIndicator(
        backgroundColor: theme.BreezColors.blue[200], value: value);
  }
}
