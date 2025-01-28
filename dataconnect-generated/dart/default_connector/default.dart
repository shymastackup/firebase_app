library default_connector;
// import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';







class DefaultConnector {
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-central1',
    'default',
    'firebse_2',
  );

  DefaultConnector({required this.dataConnect});
  static DefaultConnector get instance {
    return DefaultConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}

class ConnectorConfig {
  ConnectorConfig(String s, String t, String u);
}

class CallerSDKType {
  static var generated;
}

class FirebaseDataConnect {
  static instanceFor({required connectorConfig, required sdkType}) {}
}

