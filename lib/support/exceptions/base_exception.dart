import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract interface class BaseException implements Exception {
  String getErrorMessage(AppLocalizations l10n);
}
