//
//  CHEViewController.h
//  OpenDataURLSample
//
//  Created by Christian Herrmann on 19.10.13.
//  Copyright (c) 2013 herrm.de. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHEViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button;

- (IBAction)openTextInSafari:(id)sender;

@end
