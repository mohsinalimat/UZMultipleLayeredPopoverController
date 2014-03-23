//
//  UZMultipleLayeredContentViewController.m
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "UZMultipleLayeredContentViewController.h"

#import "UZMultipleLayeredPopoverBaseView.h"
#import "UZMultipleLayeredPopoverBackView.h"
#import "UZMultipleLayeredContentBackView.h"

/**
 * Returns size of popover which contains view controller, adding UZMultipleLayeredContentViewController's contentEdgeInsets as margin.
 * \param contentSize The size of view controller as contents.
 * \return size The size of popover which contains view controller.
 **/
CGSize UZMultipleLayeredPopoverSizeFromContentSize(CGSize contentSize) {
	CGSize popoverSize = contentSize;
	popoverSize.width += ([UZMultipleLayeredContentViewController contentEdgeInsets].left + [UZMultipleLayeredContentViewController contentEdgeInsets].right);
	popoverSize.height += ([UZMultipleLayeredContentViewController contentEdgeInsets].top + [UZMultipleLayeredContentViewController contentEdgeInsets].bottom);
	return popoverSize;
}

@implementation UZMultipleLayeredContentViewController

#pragma mark - Class method

/**
 * Returns edge insets as margin of the view controller as contents is added to UZMultipleLayeredPopoverController object.
 * \return The edge insets as margin of contents.
 **/
+ (UIEdgeInsets)contentEdgeInsets {
	return UIEdgeInsetsMake(UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin);
}

#pragma mark - Instance method

- (void)dealloc {
    DNSLogMethod
}

/**
 * Returns rectangle for this view controller's view, considering the margin around contents.
 * \return The rectangle for this view controller's view.
 **/
- (CGRect)contentFrame {
	UIEdgeInsets inverseInsets = UIEdgeInsetsMake(UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin);
	return UIEdgeInsetsInsetRect(self.view.frame, inverseInsets);
}

/**
 * Returns an initiallized UZMultipleLayeredContentViewController object.
 *
 * \param contentViewController The view controller whose content should be displayed by the popover.
 * \param contentSize The size of the view controller whose content should be displayed by the popover.
 * \return An initiallized UZMultipleLayeredContentViewController object.
 **/
- (id)initWithContentViewController:(UIViewController*)contentViewController contentSize:(CGSize)contentSize {
	if ([contentViewController isKindOfClass:[UZMultipleLayeredPopoverController class]]) {
		NSLog(@"You can not set a UZMultipleLayeredPopoverController object as the view controller on UZMultipleLayeredContentViewController objects.");
		return nil;
	}
	if ([contentViewController isKindOfClass:[UZMultipleLayeredContentViewController class]]) {
		NSLog(@"You can not set a UZMultipleLayeredContentViewController object as the view controller on UZMultipleLayeredContentViewController objects.");
		return nil;
	}
	if (!contentViewController) {
		NSLog(@"You have to set any object as the view controller on UZMultipleLayeredContentViewController objects.");
		return nil;
	}
	self = [super init];
	if (self) {
		_backView = [[UZMultipleLayeredContentBackView alloc] initWithFrame:CGRectZero];
		self.view = _backView;
		
		_baseView = [[UZMultipleLayeredPopoverBaseView alloc] initWithFrame:CGRectMake(0, 0, _popoverSize.width, _popoverSize.height)];
		[self.view addSubview:_baseView];
		[self.view sendSubviewToBack:_baseView];
		
		_contentViewController = contentViewController;
		_contentSize = contentSize;
		_popoverSize = UZMultipleLayeredPopoverSizeFromContentSize(_contentSize);
		
		contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
		[contentViewController.view.layer setCornerRadius:UZMultipleLayeredPopoverCornerRadious];
		[contentViewController.view.layer setMasksToBounds:YES];
		
		[self addChildViewController:contentViewController];
		[self.view addSubview:contentViewController.view];
		
		[self updateSubviews];
	}
	return self;
}

/**
 * The size of the content view.
 * \param contentSize The size of the view controller whose content should be displayed by the popover.
 **/
- (void)setContentSize:(CGSize)contentSize {
	_contentSize = contentSize;
	_popoverSize = UZMultipleLayeredPopoverSizeFromContentSize(_contentSize);
	[self updateSubviews];
	[_baseView setNeedsDisplay];
}

/**
 * The direction of the popover’s arrow.
 * \param direction The new arrow directions the popover is permitted to use. You can use this value to force the popover to be positioned on a specific side of the rectangle.
 **/
- (void)setDirection:(UZMultipleLayeredPopoverDirection)direction {
	_direction = direction;
	_baseView.direction = direction;
	[_baseView setNeedsDisplay];
}

/**
 * Updates all views' locations and rectangles on the this controller's view.
 **/
- (void)updateSubviews {
	_popoverSize = UZMultipleLayeredPopoverSizeFromContentSize(_contentSize);
	CGRect childViewControllerFrame = CGRectMake([UZMultipleLayeredContentViewController contentEdgeInsets].left, [UZMultipleLayeredContentViewController contentEdgeInsets].top, _contentSize.width, _contentSize.height);
	_contentViewController.view.frame = childViewControllerFrame;
	_baseView.frame = CGRectMake(0, 0, _popoverSize.width, _popoverSize.height);
	_baseView.contentEdgeInsets = [UZMultipleLayeredContentViewController contentEdgeInsets];
}

@end
