//
//  XYZToDoItem.h
//  ToDoListObjC
//
//  Created by mattwd7 on 7/14/14.
//  Copyright (c) 2014 Matt Dick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZToDoItem : NSObject

	@property NSString *itemName;
	@property BOOL completed;
	@property (readonly) NSDate *creationDate;

@end
