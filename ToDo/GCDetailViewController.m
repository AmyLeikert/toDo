//
//  GCDetailViewController.m
//  ToDo
//
//  Created by Thomas Crawford on 3/7/14.
//  Copyright (c) 2014 Thomas Crawford. All rights reserved.
//

#import "GCDetailViewController.h"
#import "GCAppDelegate.h"

@interface GCDetailViewController ()

@property (nonatomic,strong) IBOutlet UITextField *taskNameTextField;
@property (nonatomic,strong) IBOutlet UISegmentedControl *taskStatusSegControl;
@property (nonatomic,strong) IBOutlet UILabel *taskDateEnteredLabel;
@property (nonatomic,strong) IBOutlet UIDatePicker *taskDueDatePicker;

@end

@implementation GCDetailViewController

#pragma mark - Core Methods

- (GCAppDelegate *)getAppDelegate {
	UIApplication *sharedApp = [UIApplication sharedApplication];
	GCAppDelegate *appDelegate = [sharedApp delegate];
	return appDelegate;
}

#pragma mark - Interactivity Methods

- (IBAction)savePressed:(id)sender {
    if (_currentToDo == nil) {
        ToDo *newToDo = (ToDo *)[NSEntityDescription insertNewObjectForEntityForName:@"ToDo" inManagedObjectContext:_managedObjectContext];
        [newToDo setTaskName:_taskNameTextField.text];
        [newToDo setTaskDateEntered:[NSDate date]];
        [newToDo setTaskDateDue:_taskDueDatePicker.date];
        [newToDo setTaskStatus:[_taskStatusSegControl titleForSegmentAtIndex:[_taskStatusSegControl selectedSegmentIndex]]];
    } else {
        [_currentToDo setTaskName:_taskNameTextField.text];
        [_currentToDo setTaskDateEntered:[NSDate date]];
        [_currentToDo setTaskDateDue:_taskDueDatePicker.date];
        [_currentToDo setTaskStatus:[_taskStatusSegControl titleForSegmentAtIndex:[_taskStatusSegControl selectedSegmentIndex]]];
    }
    [[self getAppDelegate] saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - System Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM dd, YYYY"];
    if (_currentToDo != nil) {
        NSLog(@"Existing To Do");
        _taskNameTextField.text = [_currentToDo taskName];
        if ([[_currentToDo taskStatus] isEqualToString:[_taskStatusSegControl titleForSegmentAtIndex:0]]) {
            [_taskStatusSegControl setSelectedSegmentIndex:0];
        } else if ([[_currentToDo taskStatus] isEqualToString:[_taskStatusSegControl titleForSegmentAtIndex:1]]) {
            [_taskStatusSegControl setSelectedSegmentIndex:1];
        } else if ([[_currentToDo taskStatus] isEqualToString:[_taskStatusSegControl titleForSegmentAtIndex:2]]) {
            [_taskStatusSegControl setSelectedSegmentIndex:2];
        }
        _taskDueDatePicker.date = [_currentToDo taskDateDue];
        _taskDateEnteredLabel.text = [NSString stringWithFormat:@"Created: %@",[format stringFromDate:[_currentToDo taskDateEntered]]];
    } else {
        NSLog(@"New ToDo");
        _taskDateEnteredLabel.text = [NSString stringWithFormat:@"Created: %@",[format stringFromDate:[NSDate date]]];
    }
    [_taskNameTextField becomeFirstResponder];
}
/*
- (void)viewWillDisappear:(BOOL)animated {
    _currentToDo = nil;
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    _managedObjectContext = [[self getAppDelegate] managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
