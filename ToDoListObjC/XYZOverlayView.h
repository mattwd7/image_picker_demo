//
//  XYZOverlayView.h
//  CameraOverlay
//
//  Created by mattwd7 on 7/20/14.
//  Copyright (c) 2014 Matt Dick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZOverlayView : UIView

@property UILabel *overlayLabel;
- (void)updateLabel:(NSString *)label;

@end
