//
//  CHEViewController.m
//  OpenDataURLSample
//
//  Created by Christian Herrmann on 19.10.13.
//  Copyright (c) 2013 herrm.de. All rights reserved.
//

#import "CHEViewController.h"
#import "CHEDataURLHandler.h"

@interface CHEViewController ()

@end

@implementation CHEViewController
{
	CHEDataURLHandler *dataURLHandler;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openTextInSafari:(id)sender
{
	NSString *contentString = [NSString stringWithFormat:@"<html>%@</html>", self.textField.text];
	NSString *contentStringBase64Encoded = [[contentString dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
	
	dataURLHandler = [[CHEDataURLHandler alloc] init];
	[dataURLHandler openBase64EncodedContent:contentStringBase64Encoded];
}

@end
