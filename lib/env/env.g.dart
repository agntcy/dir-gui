// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

class _Env {
  static const List<int> _enviedkeymeasurementId = [];
  static const List<int> _envieddatameasurementId = [];
  static final String measurementId = String.fromCharCodes(
    List.generate(_envieddatameasurementId.length, (i) => i, growable: false)
        .map((i) => _envieddatameasurementId[i] ^ _enviedkeymeasurementId[i])
        .toList(growable: false),
  );
  static const List<int> _enviedkeyapiSecret = [];
  static const List<int> _envieddataapiSecret = [];
  static final String apiSecret = String.fromCharCodes(
    List.generate(_envieddataapiSecret.length, (i) => i, growable: false)
        .map((i) => _envieddataapiSecret[i] ^ _enviedkeyapiSecret[i])
        .toList(growable: false),
  );
}
