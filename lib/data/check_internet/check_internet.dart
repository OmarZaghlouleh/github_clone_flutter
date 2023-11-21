import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionStatusSingleton {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatusSingleton _singleton = ConnectionStatusSingleton._internal();
  ConnectionStatusSingleton._internal();

  //This is what's used to retrieve the instance through the app
  static ConnectionStatusSingleton getInstance() => _singleton;

  //This tracks the current connection status
  bool? hasConnection ;
  bool startConnect=true ;

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController = StreamController.broadcast();

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate

  Future <void>initCheckConnect() async {
    startConnect=true;
    ConnectivityResult  initConnect=await _connectivity.checkConnectivity();
    hasConnection = initConnect==ConnectivityResult.none?false:true;
    connectionChangeController.add(hasConnection);
  }

  void initialize() {
    initCheckConnect().then((value) {
      _connectivity.onConnectivityChanged.listen(_connectionChange);
      checkConnection();});

  }

  Stream get connectionChange => connectionChangeController.stream;

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
  }

  //flutter_connectivity's listener
  Future<void> _connectionChange(ConnectivityResult result) async {
    await checkConnection();
  }

  //The test to actually see if there is a connection
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection!;
    try {
      ConnectivityResult  initConnect=await _connectivity.checkConnectivity();
      hasConnection = initConnect==ConnectivityResult.none?false:true;

    } on SocketException catch(_) {
      hasConnection = false;
    }
    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }
    startConnect=false;
    return hasConnection!;
  }
}