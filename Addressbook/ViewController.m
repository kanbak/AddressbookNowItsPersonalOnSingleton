//
//  ViewController.m
//  Addressbook
//
//  Created by Umut Kanbak on 7/22/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "ShowViewController.h"
#import "EditViewController.h"
#import "AppDelegate.h"
#import "MySingleton.h"

@interface ViewController ()
{
    NSMutableArray *people;
    int rowNumber;
    __weak IBOutlet UITableView *myTableView;
    __weak IBOutlet UIBarButtonItem *addButtonOutlet;
    NSManagedObjectContext* managedObjectContext;
    NSMutableArray* coreDataPeople;
 //   NSFileManager *fileManager;
  //  NSURL *documentsDirectory;
 NSFetchedResultsController* fetchedResultController;
}
- (IBAction)addButton:(id)sender;

@end

@implementation ViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self=[super initWithCoder:aDecoder]) {
        managedObjectContext=[MySingleton sharedInstance].managedObjectContext;
        self.navigationItem.title=@"AddressBook";
    }
    return self;
}
- (void)viewDidLoad
{
    managedObjectContext=[MySingleton sharedInstance].managedObjectContext;
    people = [[NSMutableArray alloc] initWithCapacity:25];
    [super viewDidLoad];
    [[MySingleton sharedInstance]fetchFromCoreData];
    
    people = [NSMutableArray arrayWithArray:fetchedResultController.fetchedObjects];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

}
- (void)viewWillAppear:(BOOL)animated
{
    [[MySingleton sharedInstance]fetchFromCoreData];
    people = [NSMutableArray arrayWithArray:fetchedResultController.fetchedObjects];
    [myTableView reloadData];
    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {//editing mode
    [super setEditing:editing animated:animated];
    [myTableView setEditing:editing animated:animated];
}

- (IBAction)setEditMode:(UIBarButtonItem *)sender {
    if (self.editing) {
        sender.title = @"Edit";
        sender.style = UIBarButtonItemStylePlain;
        [super setEditing:NO animated:YES];
    } else {
        sender.title = @"Done";
        sender.style = UIBarButtonItemStyleDone;
        [super setEditing:YES animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark tableViewModifications

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person *person=[people objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myIdentifier"];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: @"myIdentifier"];}
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", person.firstName, person.lastName];
    cell.detailTextLabel.text = person.emailAddress;
    return cell;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [people count];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ShowViewController *showViewController = segue.destinationViewController;
    Person *selectedPerson = [people objectAtIndex:rowNumber];
    showViewController.person = selectedPerson;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    rowNumber = indexPath.row;
    [self performSegueWithIdentifier:@"showView" sender:self];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete){
       //delete from database
        [[MySingleton sharedInstance].managedObjectContext deleteObject:[people objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![[MySingleton sharedInstance].managedObjectContext save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
/////////////
        [people removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
   // }else if (editingStyle==UITableViewCellEditingStyleInsert){
        //[people  insertObject:@"newPerson" atIndex:indexPath.row];
       // [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (IBAction)addButton:(id)sender {
    [self performSegueWithIdentifier:@"toAddView" sender:self];
    
}
@end
