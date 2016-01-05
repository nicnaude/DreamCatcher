//
//  ListViewController.m
//  DreamCatcher
//
//  Created by Nicholas Naudé on 05/01/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *titlesArray;

@property NSMutableArray *descriptionsArray;

@end

@implementation ListViewController

//VIEW DID LOAD
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlesArray = [NSMutableArray new];
    self.descriptionsArray = [NSMutableArray new];
    self.editing = false;
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setTintColor:[UIColor whiteColor]];
}

// ask the user for input and save it.
- (void) presentDreamEntry
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"What did you dream about?" message:nil preferredStyle: UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Dream title";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Description";
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *textFieldOne = alertController.textFields[0];
        UITextField *textFieldTwo = alertController.textFields[1];
        
        [self.titlesArray addObject:textFieldOne.text];
        [self.descriptionsArray addObject:textFieldTwo.text];
        
        [self.tableView reloadData];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

// enables user to delete a row.

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.titlesArray removeObjectAtIndex:indexPath.row]; // remove the header.
    [self.descriptionsArray removeObjectAtIndex:indexPath.row]; // remove the description
    [self.tableView reloadData];
}


- (IBAction)onEditButtonTapped:(UIBarButtonItem *)sender
{
    // deleting items from the list.
    if (self.editing)
    {
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
        NSLog(@"false");
    }
    else
    {
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
        NSLog(@"true");
    }
}

- (IBAction)onAddButtonTapped:(UIBarButtonItem *)sender {
    [self presentDreamEntry];
}

// allow the user to reorder the tableView. Allows the user to edit the tableView.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// allow the user to reorder the tableView. The following allows the user to move the item up or down in the list.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// allow the user to reorder the tableView. The following edits the arrays.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *titleItem = [self.titlesArray objectAtIndex:sourceIndexPath.row];
    [self.titlesArray removeObject:titleItem];
    [self.titlesArray insertObject: titleItem atIndex:destinationIndexPath.row];
    
    NSString *descriptionItem = [self.descriptionsArray objectAtIndex:sourceIndexPath.row];
    [self.titlesArray removeObject:descriptionItem];
    [self.titlesArray insertObject: descriptionItem atIndex:destinationIndexPath.row];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.titlesArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detailVC = segue.destinationViewController;
    detailVC.titleString = [self.titlesArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    detailVC.descriptionString = [self.descriptionsArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
}

@end
