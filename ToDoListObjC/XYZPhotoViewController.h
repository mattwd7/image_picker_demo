//
//  XYZPhotoViewController.h
//  multiCamera
//
//  Created by mattwd7 on 7/27/14.
//  Copyright (c) 2014 Matt Dick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZPhoto.h"

@interface XYZPhotoViewController : UIViewController

@property XYZPhoto *photo;
@property (strong, nonatomic) IBOutlet UILabel *imageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
