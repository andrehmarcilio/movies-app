import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'base_exception.dart';

class ApiException implements BaseException {
  final int? statusCode;
  final String? message;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() {
    return 'ApiException: $message (status code $statusCode)';
  }

  @override
  String getErrorMessage(AppLocalizations l10n) {
    final statusCode = this.statusCode;

    if (statusCode == null) {
      return l10n.errorMessageGeneric;
    } else if (statusCode == 401) {
      return l10n.errorMessageUnauthorized;
    } else if (statusCode == 404) {
      return l10n.errorMessageNotFound;
    } else if (statusCode >= 400 && statusCode < 500) {
      return l10n.errorMessageClientError;
    } else if (statusCode >= 500 && statusCode < 600) {
      return l10n.errorMessageServerError;
    } else {
      return l10n.errorMessageGeneric;
    }
  }
}
