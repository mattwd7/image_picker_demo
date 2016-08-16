//
//  XYZToDoListTableViewController.m
//  ToDoListObjC
//
//  Created by mattwd7 on 7/14/14.
//  Copyright (c) 2014 Matt Dick. All rights reserved.
//

#import "XYZToDoListTableViewController.h"
#import "XYZPhotosTableViewController.h"
#import "XYZToDoItem.h"
#import "XYZOverlayView.h"
#import "XYZPhoto.h"
#import "XYZCameraViewController.h"
#import "XYZPhotoViewController.h"

@interface XYZToDoListTableViewController ()

@end

@implementation XYZToDoListTableViewController

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
	self.toDoItems = [[NSMutableArray alloc] init];
	self.photos = [[NSMutableArray alloc] init];
	[self loadInitialData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
	return [self.toDoItems count];
}
-(void)loadInitialData
{
	NSArray *items = [[NSArray alloc] initWithObjects:@"Cabinet", @"Door", @"Drywall", @"Electrical", @"Fireplace", @"Floor", @"HVAC", @"Interior Trim", @"Paint/Stain", @"Telecommunication", @"Window", nil];
	for (NSString *item in items) {
		XYZToDoItem *newItem = [[XYZToDoItem alloc] init];
		newItem.itemName = item;
		[self.toDoItems addObject:newItem];
	}
	
}

- (void)createPhoto:(UIImage *)newImage assocItems:(NSString *)itemsString
{
	XYZPhoto *newPhoto = [[XYZPhoto alloc] init];
	newPhoto.img = newImage;
	newPhoto.associatedItems = itemsString;
	[self.photos addObject:newPhoto];
}

- (IBAction)openCamera:(id)sender
{
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera Error" message:@"No camera on this device." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
	} else {
		NSPredicate *myFilter = [NSPredicate predicateWithFormat:@"completed = YES"];
		NSString *myItems = [[[self.toDoItems filteredArrayUsingPredicate:myFilter] valueForKey:@"itemName" ] 	componentsJoinedByString:@", "];
		
		XYZCameraViewController *cvc = [[XYZCameraViewController alloc] init];
		cvc.rootVC = self;
		cvc.labelString = myItems;
		[self.navigationController setToolbarHidden:YES];
		[self.navigationController presentViewController:cvc animated:YES completion:NULL];
	}
	
	/*
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera Error" message:@"No camera on this device." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
	} else {
		//Create camera overlay and pass selected items to it
		XYZOverlayView *overlay = [[XYZOverlayView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		NSPredicate *myFilter = [NSPredicate predicateWithFormat:@"completed = YES"];
		NSString *temp = [[[self.toDoItems filteredArrayUsingPredicate:myFilter] valueForKey:@"itemName" ] 	componentsJoinedByString:@", "];
		[overlay updateLabel:temp];
		
		//Pull up camera with options
		UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
		ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
		ipc.allowsEditing = NO;
		ipc.delegate = self;
		ipc.cameraOverlayView = overlay;
		
		[self.navigationController presentViewController:ipc animated:YES completion:NULL];
	}
	 */
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    XYZToDoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
	cell.textLabel.text = toDoItem.itemName;
	if (toDoItem.completed){
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
    return cell;
	
}

/*
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[self dismissViewControllerAnimated:YES completion:NULL];
	//NSLog(@"%d", [self.navigationController.viewControllers count]);
	UIImage *myImage = [info objectForKey:UIImagePickerControllerOriginalImage];
	NSPredicate *myFilter = [NSPredicate predicateWithFormat:@"completed = YES"];
	NSString *myItems = [[[self.toDoItems filteredArrayUsingPredicate:myFilter] valueForKey:@"itemName" ] 	componentsJoinedByString:@", "];
	[self createPhoto:myImage assocItems:myItems];
}
 */

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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.	
	
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	XYZToDoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
	tappedItem.completed = !tappedItem.completed;
	[tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
	
}

@end