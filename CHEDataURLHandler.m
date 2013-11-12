//
//  CHEDataURLHandler.m
//  OpenDataURLSample
//
//  Created by Christian Herrmann on 12.11.13.
//  Copyright (c) 2013 HerrmDE. All rights reserved.
//

#import "CHEDataURLHandler.h"
#import "HTTPServer.h"
#import "DDTTYLogger.h"
#import "DDLog.h"


@implementation CHEDataURLHandler
{
	HTTPServer *httpServer;
}

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

- (BOOL)openBase64EncodedContent:(NSString *)contentString
{
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	httpServer = [[HTTPServer alloc] init];
	[httpServer setType:@"_http._tcp."];
	[httpServer setPort:33664];
	
	//Creating document root at documents folder
	NSString *documentRoot = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"Web"];
	[[NSFileManager defaultManager] createDirectoryAtPath:documentRoot withIntermediateDirectories:YES attributes:nil error:nil];
	[httpServer setDocumentRoot:documentRoot];
	
	//Creating index.html with redirect to data url
	NSString* fileAtPath = [httpServer.documentRoot stringByAppendingPathComponent:@"index.html"];
	[[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
	
	NSString *indexHTMLString = [NSString stringWithFormat:@"<head><meta http-equiv=\"refresh\" content=\"0; URL=data:text/html;charset=UTF-8;base64,%@\"></head>", contentString];
	[[indexHTMLString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
	
	NSError *error;
	if (![httpServer start:&error])
	{
		DDLogError(@"Error starting HTTP Server: %@", error);
	}
	
	//Starting web server
    NSString* server = [NSString stringWithFormat:@"http://localhost:%hu", httpServer.listeningPort];
    NSURL *myURL = [NSURL URLWithString: [NSString stringWithFormat: @"%@", server]];
    [[UIApplication sharedApplication] openURL:myURL];
	
	return [[UIApplication sharedApplication] openURL:myURL];;
}

@end
