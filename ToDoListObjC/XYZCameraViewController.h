//
//  XYZCameraViewController.h
//  multiCamera
//
//  Created by mattwd7 on 7/26/14.
//  Copyright (c) 2014 Matt Dick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZToDoListTableViewController.h"
#import "XYZImagePreview.h"

@interface XYZCameraViewController : UIViewController

@property XYZToDoListTableViewController *rootVC;
@property NSMutableArray *photoData;
@property NSString *labelString;

@property (strong, nonatomic) IBOutlet UIView *cameraView;
@property (strong, nonatomic) IBOutlet UILabel *cameraLabel;
@property (nonatomic, strong) UIView *whiteFlash;

- (IBAction)cancelCamera:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (void)showImagePreview:(UIImage *)image;
- (void)hideImagePreview:(BOOL)deleteImage;

@end
