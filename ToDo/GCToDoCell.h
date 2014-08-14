//
//  GCToDoCell.h
//  ToDo
//
//  Created by Thomas Crawford on 3/7/14.
//  Copyright (c) 2014 Thomas Crawford. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCToDoCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *todoLabel;
@property (nonatomic,strong) IBOutlet UILabel *todoDateLabel;
@property (nonatomic,strong) IBOutlet UILabel *todoStatusLabel;

@end
