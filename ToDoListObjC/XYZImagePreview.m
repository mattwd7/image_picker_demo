//
//  XYZImagePreview.m
//  multiCamera
//
//  Created by mattwd7 on 8/6/14.
//  Copyright (c) 2014 Matt Dick. All rights reserved.
//

#import "XYZImagePreview.h"
#import "XYZCameraViewController.h"

@interface XYZImagePreview ()

@end

@implementation XYZImagePreview

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.imagePreview.image = self.previewPhoto;
	[NSTimer scheduledTimerWithTimeInterval:2.0
									 target:self
								   selector:@selector(closeImagePreview)
								   userInfo:nil
									repeats:NO];
}

- (IBAction)deletePreviewPhoto:(id)sender {
	[self.cameraVC.photoData removeLastObject];
	[self closeImagePreview];
}

- (void)closeImagePreview{
	[self dismissViewControllerAnimated:NO completion:NULL];
}

@end
