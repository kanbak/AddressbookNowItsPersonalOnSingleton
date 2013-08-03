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
#import "EditDelegate.h"

@interface ViewController ()
{
    NSMutableArray *people;
    int path;
    __weak IBOutlet UITableView *myTableView;
}
/*
- (IBAction)setEditMode:(UIBarButtonItem *)sender;
*/
@end

@implementation ViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self=[super initWithCoder:aDecoder]) {
        Person *person1 = [[Person alloc]init];
        Person *person2 = [[Person alloc]init];
        Person *person3 = [[Person alloc]init];
        Person *person4 = [[Person alloc]init];
        
        person1.firstName = @"Brian";
        person1.lastName = @"Dinh";
        person1.emailAddress = @"brian@dinh.com";
        person1.phoneNumber = @"999-99-9999";
        
        person2.firstName = @"Umut";
        person2.lastName = @"Kanbak";
        person2.emailAddress = @"umut@kanbak.com";
        person2.phoneNumber = @"666-66-6666";
        
        person3.firstName = @"Some";
        person3.lastName = @"Person";
        person3.emailAddress = @"some@person.com";
        person3.phoneNumber = @"777-77-7777";
        
        person4.firstName = @"Another";
        person4.lastName = @"Person";
        person4.emailAddress = @"another@person.com";
        person4.phoneNumber = @"555-55-5555";
        
        people = [[NSMutableArray alloc]initWithObjects:person1, person2, person3, person4, nil];}
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;//editing mode button
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

#pragma mark UITableviewDataSource

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myIdentifier"];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: @"myIdentifier"];}
        
        cell.textLabel.text=[[people objectAtIndex:indexPath.row]lastName];
        cell.detailTextLabel.text=[[people objectAtIndex:indexPath.row]firstName];
    return cell;    
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [people count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    path=indexPath.row;
    [self performSegueWithIdentifier:@"showView" sender:self];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete){
        [people removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else if (editingStyle==UITableViewCellEditingStyleInsert){
        [people  insertObject:@"Uninitialized" atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ShowViewController *showViewController = segue.destinationViewController;
    showViewController.firstNameString=[[people objectAtIndex:path]firstName];
    showViewController.lastNameString=[[people objectAtIndex:path]lastName];
    showViewController.emailAddressString=[[people objectAtIndex:path]emailAddress];
    showViewController.phoneNumberString=[[people objectAtIndex:path]phoneNumber];
}

@end
