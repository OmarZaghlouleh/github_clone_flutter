import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'check_internet.dart';
import 'package:overlay_support/overlay_support.dart';


ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
late StreamSubscription connectionChangeStream;

bool offlineMsgShow=false;
late OverlaySupportEntry x;


checkInternetApp() {
  connectionStatus.initialize();
  connectionChangeStream = connectionStatus.connectionChange.listen(
          (isOnline)  {
         if (isOnline) {
          if(offlineMsgShow)  x.dismiss();
          offlineMsgShow=false;
          if (kDebugMode) {
            print('================online');
          }
           connectionStatus.startConnect==false ?showSimpleNotification(
            Text("تم استعادة الاتصال بالانترنيت",
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xffE0E0E0).withOpacity(0.72),
                  height: 1.5),),
            background: Colors.green,
            elevation: 0.1,
          ):null;
        }
        if (!isOnline){
          offlineMsgShow=true;
          if (kDebugMode) {
            print('================offline');
          }
          x = showSimpleNotification(
            autoDismiss: false,
            Text('لا يوجد الاتصال بالانترنيت',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xffE0E0E0).withOpacity(0.72),
                  height: 1.5),),
            background: Colors.red,
            elevation: 0.1,
          );
        }
      });
}