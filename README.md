OpenBase64EncodedDataWithSafari
===============================

For some reason UIApplication's openURL does not open base64 encoded data urls within safari on iOS.
With this class it is possible by starting a web server (e.g. CocoaHTTPServer) to represent a html file, which redirects to the base64 encoded data url.


* copy OpenBase64EncodedDataWithSafari to your project folder
* import CHEDataURLHandler.h
* use 'openBase64EncodedContent:(NSString *)contentString'
