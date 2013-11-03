OpenBase64EncodedDataWithSafari
===============================

For some reason UIApplication's openURL does not open base64 encoded data urls within safari on iOS.
With this category it is possible by starting web server (e.g. CocoaHTTPServer) to represent a html file, which redirects to the base64 encoded data url.
