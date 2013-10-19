//
//  UIApplication+DataURL.m
//  OpenBase64EncodedDataURLWithSafari
//
//  Created by Christian Herrmann on 19.10.13.
//  Copyright (c) 2013 herrm.de. All rights reserved.
//

#import "UIApplication+DataURL.h"
#import "HTTPServer.h"
#import "DDTTYLogger.h"
#import "DDLog.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;
static const int chePort = 33654;
static const HTTPServer *cheHTTPServer;

@implementation UIApplication (DataURL)

- (BOOL)openBase64EncodedContent:(NSString *)contentString
{
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	cheHTTPServer = [[HTTPServer alloc] init];
	[cheHTTPServer setType:@"_http._tcp."];
	[cheHTTPServer setPort:CHEPort];
	
	//Setting document root to documents folder
	NSString *documentRoot = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"Web"];
	[[NSFileManager defaultManager] createDirectoryAtPath:documentRoot withIntermediateDirectories:YES attributes:nil error:nil];
	[cheHTTPServer setDocumentRoot:documentRoot];
	
	//Creating index.html which redirects to the data url
	NSString* fileAtPath = [cheHTTPServer.documentRoot stringByAppendingPathComponent:@"index.html"];
	[[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
	
	NSString *indexHTMLString = [NSString stringWithFormat:@"<head><meta http-equiv=\"refresh\" content=\"0; URL=data:text/html;charset=UTF-8;base64,%@\"></head>", contentString];
	[[indexHTMLString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
	
	NSError *error;
	if (![cheHTTPServer start:&error])
	{
		DDLogError(@"Error starting HTTP Server: %@", error);
	}
	
	//Starting web server
    NSString* server = [NSString stringWithFormat:@"http://localhost:%hu", cheHTTPServer.listeningPort];
    NSURL *myURL = [NSURL URLWithString: [NSString stringWithFormat: @"%@", server]];
    [[UIApplication sharedApplication] openURL:myURL];
	
	return [[UIApplication sharedApplication] openURL:myURL];;
}

@end
