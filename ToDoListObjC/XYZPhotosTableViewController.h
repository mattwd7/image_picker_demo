//
//  XYZPhotosTableViewController.h
//  multiCamera
//
//  Created by mattwd7 on 7/21/14.
//  Copyright (c) 2014 Matt Dick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZPhoto.h"
#import "XYZPhotoViewController.h"

@interface XYZPhotosTableViewController : UITableViewController

@property NSMutableArray *photos;
@property XYZPhoto *selectedPhoto;
@property XYZPhotoViewController *photoVC;

- (void)loadInitalData;

@end
