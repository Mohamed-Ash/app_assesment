import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkInternetConnectivityHelper() async{
  var connectivityResult = await (Connectivity().checkConnectivity());
  
  if (connectivityResult.contains(ConnectivityResult.none)) {
    
    return false; // No internet connection
  }
  return true; // Internet connection is available

}