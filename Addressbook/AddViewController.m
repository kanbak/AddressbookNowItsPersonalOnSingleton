//
//  AddViewController.m
//  Addressbook
//
//  Created by Umut Kanbak on 8/7/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "AddViewController.h"
#import "AppDelegate.h"
#import "Person.h"
#import "MySingleton.h"


@interface AddViewController ()
{
    __weak IBOutlet UITextField *firstNameTextField;
    __weak IBOutlet UITextField *lastNameTextField;
    __weak IBOutlet UITextField *emailAddressTextField;
    __weak IBOutlet UITextField *phoneNumberTextField;
}
- (IBAction)savePerson:(id)sender;

@end

@implementation AddViewController
@synthesize person;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"add contact";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)savePerson:(id)sender {
    //NSManagedObjectContext *managedObjectContext=[MySingleton sharedInstance].managedObjectContext;
    NSError *error;
    person = [NSEntityDescription insertNewObjectForEntityForName: @"Person" inManagedObjectContext: [MySingleton sharedInstance].managedObjectContext];
    person.firstName=firstNameTextField.text;
    person.lastName=lastNameTextField.text;
    person.emailAddress=emailAddressTextField.text;
    person.phoneNumber=phoneNumberTextField.text;
    
    if (![[MySingleton sharedInstance].managedObjectContext save:&error]) {
        NSLog(@"Error:%@",error);
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
