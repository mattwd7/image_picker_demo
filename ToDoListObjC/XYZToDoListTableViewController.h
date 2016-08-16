//
//  XYZToDoListTableViewController.h
//  ToDoListObjC
//
//  Created by mattwd7 on 7/14/14.
//  Copyright (c) 2014 Matt Dick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZPhoto.h"

@interface XYZToDoListTableViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property NSMutableArray *toDoItems;
@property NSMutableArray *photos;

- (void)loadInitialData;
- (IBAction)openCamera:(id)sender;
- (void)createPhoto:(UIImage *)newImage assocItems:(NSString *)itemsString;

@end
