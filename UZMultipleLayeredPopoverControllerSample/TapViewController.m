//
//  TapViewController.m
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "TapViewController.h"
#import "UZMultipleLayeredPopoverController.h"

@interface TapViewController ()
@end

@implementation TapViewController

- (IBAction)up:(id)sender {
	UIButton *button = sender;
	[self showAtButtonFrame:button.frame direction:UZMultipleLayeredPopoverBottomDirection];
}

- (IBAction)down:(id)sender {
	UIButton *button = sender;
	[self showAtButtonFrame:button.frame direction:UZMultipleLayeredPopoverTopDirection];
}

- (IBAction)left:(id)sender {
	UIButton *button = sender;
	[self showAtButtonFrame:button.frame direction:UZMultipleLayeredPopoverLeftDirection];
}

- (IBAction)right:(id)sender {
	UIButton *button = sender;
	[self showAtButtonFrame:button.frame direction:UZMultipleLayeredPopoverRightDirection];
}

- (IBAction)any:(id)sender {
	UIButton *button = sender;
	[self showAtButtonFrame:button.frame direction:UZMultipleLayeredPopoverAnyDirection];
}

- (IBAction)closeThis:(id)sender {
	[self dismissCurrentPopoverController];
}

- (IBAction)closeAll:(id)sender {
	[self dismissMultipleLayeredPopoverController];
}

- (IBAction)vertical:(id)sender {
	UIButton *button = sender;
	[self showAtButtonFrame:button.frame direction:UZMultipleLayeredPopoverVerticalDirection];
}

- (IBAction)horizontal:(id)sender {
	UIButton *button = sender;
	[self showAtButtonFrame:button.frame direction:UZMultipleLayeredPopoverHorizontalDirection];
}

- (void)showAtButtonFrame:(CGRect)buttonFrame direction:(UZMultipleLayeredPopoverDirection)direction {
	UIApplication *application = [UIApplication sharedApplication];
	UIViewController *vc = [application.keyWindow.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"TapViewController"];
	[self presentMultipleLayeredPopoverWithViewController:vc
											  contentSize:CGSizeMake(320, 480)
												 fromRect:buttonFrame
												   inView:self.view
												direction:direction];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

@end
