//
//  XYZOverlayView.m
//  CameraOverlay
//
//  Created by mattwd7 on 7/20/14.
//  Copyright (c) 2014 Matt Dick. All rights reserved.
//

#import "XYZOverlayView.h"
#import "XYZToDoListTableViewController.h"

@implementation XYZOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];

		self.overlayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 360, 100)];
		self.overlayLabel.backgroundColor = [UIColor clearColor];
		self.overlayLabel.font = [UIFont fontWithName:@"Courier" size: 18.0];
		self.overlayLabel.textColor = [UIColor whiteColor];
		//self.overlayLabel.numberOfLines = 3;
		self.overlayLabel.text = @"test from UIView";
		
		[self addSubview:self.overlayLabel];
    }
    return self;
}

- (void)updateLabel:(NSString *)label
{
	self.overlayLabel.text = label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
