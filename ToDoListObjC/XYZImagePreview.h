//
//  XYZImagePreview.h
//  multiCamera
//
//  Created by mattwd7 on 8/6/14.
//  Copyright (c) 2014 Matt Dick. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYZCameraViewController;

@interface XYZImagePreview : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imagePreview;
@property (strong, nonatomic) UIImage *previewPhoto;
@property (weak, nonatomic) XYZCameraViewController *cameraVC;

- (IBAction)deletePreviewPhoto:(id)sender;
- (void)closeImagePreview;

@end
