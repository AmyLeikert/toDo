//
//  ToDo.h
//  ToDo
//
//  Created by Thomas Crawford on 3/7/14.
//  Copyright (c) 2014 Thomas Crawford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ToDo : NSManagedObject

@property (nonatomic, retain) NSDate * taskDateEntered;
@property (nonatomic, retain) NSDate * taskDateDue;
@property (nonatomic, retain) NSString * taskName;
@property (nonatomic, retain) NSString * taskStatus;

@end
