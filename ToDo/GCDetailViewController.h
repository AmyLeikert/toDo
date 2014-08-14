//
//  GCDetailViewController.h
//  ToDo
//
//  Created by Thomas Crawford on 3/7/14.
//  Copyright (c) 2014 Thomas Crawford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDo.h"

@interface GCDetailViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) ToDo *currentToDo;

@end
