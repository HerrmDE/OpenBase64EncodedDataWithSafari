//
//  UIApplication+DataURL.h
//  OpenBase64EncodedDataURLWithSafari
//
//  Created by Christian Herrmann on 19.10.13.
//  Copyright (c) 2013 herrm.de. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (DataURL)

- (BOOL)openBase64EncodedContent:(NSString *)contentString;

@end
