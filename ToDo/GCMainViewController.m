//
//  GCMainViewController.m
//  ToDo
//
//  Created by Thomas Crawford on 3/7/14.
//  Copyright (c) 2014 Thomas Crawford. All rights reserved.
//

#import "GCMainViewController.h"
#import "GCAppDelegate.h"
#import "ToDo.h"
#import "GCToDoCell.h"
#import "GCDetailViewController.h"

@interface GCMainViewController ()

@property (nonatomic,strong) NSMutableArray *todoArray;
@property (nonatomic,strong) IBOutlet UITableView *todoTableView;

@end

@implementation GCMainViewController

#pragma mark - Core Methods

- (GCAppDelegate *)getAppDelegate {
	UIApplication *sharedApp = [UIApplication sharedApplication];
	GCAppDelegate *appDelegate = [sharedApp delegate];
	return appDelegate;
}

- (void)fetchToDos {
    NSLog(@"Fetch...");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDo" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"taskDateDue" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error;
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([fetchResults count] > 0) {
        _todoArray = [NSMutableArray arrayWithArray:fetchResults];
    }
}

#pragma mark - System Methods

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _managedObjectContext = [[self getAppDelegate] managedObjectContext];
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchToDos];
    [_todoTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Interactivity Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"editToDetailSegue"]) {
        ToDo *currentToDo = [_todoArray objectAtIndex:[[_todoTableView indexPathForSelectedRow] row]];
        GCDetailViewController *destController = [segue destinationViewController];
        destController.currentToDo = currentToDo;
    }
}

#pragma mark - TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_todoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GCToDoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    ToDo *currentToDo = [_todoArray objectAtIndex:[indexPath row]];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd"];
    cell.todoLabel.text = [currentToDo taskName];
    cell.todoDateLabel.text = [format stringFromDate:[currentToDo taskDateDue]];
    cell.todoStatusLabel.text = [currentToDo taskStatus];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
